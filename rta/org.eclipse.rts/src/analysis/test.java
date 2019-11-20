package analysis;
import analysis.RTA;


public class test {
	// Ci, Ti, Di, Pi, Ji
	static int tasks[ ][ ]={
			{  6, 2200,  896,  10, 1},
			{ 10, 1400, 1382,  9,  1},
			{414, 2700, 1723,  8,  5},
			{112, 2400, 2016,  7,  2},
			{ 29, 3100, 2323,  6,  1},
			{ 88, 2800, 2744,  5,  1},
			{ 64, 4400, 2949,  4,  1},
			{288, 6200, 3605,  3,  3},
			{518, 5800, 4800,  2,  6},
			{793, 8900, 7607,  1,  8}};

	public static void main(String[] args) {
		RTA r = new RTA();

		long[] ans = r.ResponseTimeAnalysis(tasks);

		for (int i = 0; i < ans.length; i++){
			System.out.println(ans[i]);
		}


		System.out.println(r.schedulabilityTest(tasks));
		return;
	}
}
