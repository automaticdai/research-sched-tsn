package analysis;

import java.util.ArrayList;
import java.util.Arrays;

public class RTA_TSN {

	int M = 1500;

	/**
	 * Assumptions: implicit deadlines for all packets;
	 * 
	 * @param packets
	 *            parameters: [C_i, T_i, D_i, P_i, J_i]
	 * @return true or false, regarding schedulability
	 */
	public boolean schedulabilityTest(int[][] packets) {
		/*
		 * Sort by P_i, decreasing
		 */
		Arrays.sort(packets, (a, b) -> -Double.compare(a[3], b[3]));

		/*
		 * Get sub-packets by MTU.
		 */
		ArrayList<ArrayList<int[]>> subPackets = getSubPackets(packets);

		/*
		 * Get response time of each sub-packet.
		 */
		long[][] responseTime = getResponseTime(subPackets);

		return isSchedulable(responseTime, subPackets);
	}

	/**
	 * Assumptions: implicit deadlines for all packets;
	 * packets.
	 * 
	 * @param packets
	 *            parameters: [C_i, T_i, D_i£¬ P_i]
	 * @return response time of each packet
	 */
	public long[] ResponseTimeAnalysis(int[][] packets) {
		/*
		 * Sort by P_i, decreasing
		 */
		Arrays.sort(packets, (a, b) -> -Double.compare(a[3], b[3]));

		/*
		 * Get sub-packets by MTU.
		 */
		ArrayList<ArrayList<int[]>> subPackets = getSubPackets(packets);

		/*
		 * Get response time of each sub-packet.
		 */
		long[][] responseTimeSubPacket = getResponseTime(subPackets);

		/*
		 * Get response time of each packet.
		 */
		long[] responseTime = new long[subPackets.size()];

		for (int i = 0; i < subPackets.size(); i++) {
			int lastSubPacketIndex = subPackets.get(i).size() - 1;
			responseTime[i] = responseTimeSubPacket[i][lastSubPacketIndex];
		}

		return responseTime;
	}

	/**
	 * Divide packet into sub-packets by MTU
	 * 
	 * @return sub-packets
	 */
	private ArrayList<ArrayList<int[]>> getSubPackets(int[][] packets) {

		ArrayList<ArrayList<int[]>> subPakcets = new ArrayList<>();

		for (int i = 0; i < packets.length; i++) {
			int C = packets[i][0];
			int T = packets[i][1];
			int D = packets[i][2];
			int P = packets[i][3];
			int J = packets[i][4];

			int numberOfSubpackets = (int) Math.ceil((double) C / (double) M);
			int CforLastSubPacket = C % M == 0 ? M : C % M;

			double queuingRate = (double) J / (double) C;

			ArrayList<int[]> subPacketsForOne = new ArrayList<>();

			// j: the index of a sub-packet
			for (int j = 0; j < numberOfSubpackets; j++) {
				int[] oneSubPacket = new int[7];
				oneSubPacket[0] = i + 1; // packetID
				oneSubPacket[1] = j + 1; // subPacketID
				oneSubPacket[2] = (j == numberOfSubpackets - 1) ? CforLastSubPacket : M; // C
				oneSubPacket[3] = T; // T
				oneSubPacket[4] = D; // D
				oneSubPacket[5] = P; // P
				oneSubPacket[6] = (int) Math.ceil(oneSubPacket[2] * queuingRate); // J

				subPacketsForOne.add(oneSubPacket);
			}
			subPakcets.add(subPacketsForOne);
		}

		return subPakcets;
	}

	private boolean isSchedulable(long[][] responseTime, ArrayList<ArrayList<int[]>> subPackets) {

		for (int i = 0; i < subPackets.size(); i++) {
			for (int j = 0; j < subPackets.get(i).size(); j++) {
				if (subPackets.get(i).get(j)[4] < responseTime[i][j])
					return false;
			}

		}
		return true;
	}

	/**
	 * @param subpackets
	 *            parameters: [PacketID, subPacketID, C_i, T_i, D_i,P_i,J_i]
	 * @return the exact response time of each packet
	 */
	private long[][] getResponseTime(ArrayList<ArrayList<int[]>> subPackets) {
		long[][] responseTime = new long[subPackets.size()][];

		// busy-windows for calculating response time of each sub-packet
		for (int i = 0; i < subPackets.size(); i++) {
			responseTime[i] = new long[subPackets.get(i).size()];

			for (int j = 0; j < subPackets.get(i).size(); j++) {
				int packetID = subPackets.get(i).get(j)[0];
				int subPacketID = subPackets.get(i).get(j)[1];
				int C = subPackets.get(i).get(j)[2];
				int D = subPackets.get(i).get(j)[4];
				int P = subPackets.get(i).get(j)[5];

				long B = getB(P, subPackets);
				long R = B;

				boolean isEqual = false, missDeadline = false;

				/*
				 * Busy-window for computing W
				 */
				while (!isEqual) {
					isEqual = true;

					long newR = getW(R, B, P, packetID, subPacketID, subPackets);

					if (newR != R)
						isEqual = false;
					if (newR > D)
						missDeadline = true;

					R = newR;

					if (missDeadline)
						break;
				}

				R += C;

				for (int k = 0; k <= j; k++) {
					R += subPackets.get(i).get(k)[6];
				}

				responseTime[i][j] = R;
			}
		}

		return responseTime;
	}

	/**
	 * Get Arrival blocking, caused by lower priority sub-packets.
	 * 
	 * @return B
	 */
	private long getB(int p, ArrayList<ArrayList<int[]>> subPackets) {

		long maxC = 0;

		for (int i = 0; i < subPackets.size(); i++) {
			for (int j = 0; j < subPackets.get(i).size(); j++) {
				int P = subPackets.get(i).get(j)[5];
				if (p > P)
					maxC = Math.max(maxC, subPackets.get(i).get(j)[2]);
			}
		}

		return maxC;
	}

	private long getW(long R, long B, int p, int packetID, int subPacketID, ArrayList<ArrayList<int[]>> subPackets) {
		/*
		 * delay from its previous sub-packets
		 */
		long previousSubpacketDelay = 0;
		for (int i = 0; i < subPacketID - 1; i++) {
			previousSubpacketDelay += subPackets.get(packetID - 1).get(i)[2];
		}

		/*
		 * interference from higher priority sub-packets
		 */
		long interference = 0;
		for (int i = 0; i < subPackets.size(); i++) {
			for (int j = 0; j < subPackets.get(i).size(); j++) {
				int C = subPackets.get(i).get(j)[2];
				int T = subPackets.get(i).get(j)[3];
				int P = subPackets.get(i).get(j)[5];
				int J = subPackets.get(i).get(j)[6];
				if (P > p) {
					interference += Math.ceil((double) (R + J) / (double) T) * C;
				}
			}
		}

		return B + previousSubpacketDelay + interference;
	}

}
