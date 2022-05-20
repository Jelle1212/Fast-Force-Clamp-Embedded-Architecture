library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pid_parameters_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface P
		C_P_DATA_WIDTH	: integer	:= 32;
		C_P_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface I
		C_I_DATA_WIDTH	: integer	:= 32;
		C_I_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface D
		C_D_DATA_WIDTH	: integer	:= 32;
		C_D_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface N
		C_N_DATA_WIDTH	: integer	:= 32;
		C_N_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface S
		C_S_DATA_WIDTH	: integer	:= 32;
		C_S_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
		p_out :	out std_logic_vector(C_P_DATA_WIDTH-1 downto 0);
		i_out :	out std_logic_vector(C_I_DATA_WIDTH-1 downto 0);
		d_out :	out std_logic_vector(C_D_DATA_WIDTH-1 downto 0);
		n_out :	out std_logic_vector(C_N_DATA_WIDTH-1 downto 0);
		s_out :	out std_logic_vector(C_S_DATA_WIDTH-1 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface P
		p_aclk	: in std_logic;
		p_aresetn	: in std_logic;
		p_awaddr	: in std_logic_vector(C_P_ADDR_WIDTH-1 downto 0);
		p_awprot	: in std_logic_vector(2 downto 0);
		p_awvalid	: in std_logic;
		p_awready	: out std_logic;
		p_wdata	: in std_logic_vector(C_P_DATA_WIDTH-1 downto 0);
		p_wstrb	: in std_logic_vector((C_P_DATA_WIDTH/8)-1 downto 0);
		p_wvalid	: in std_logic;
		p_wready	: out std_logic;
		p_bresp	: out std_logic_vector(1 downto 0);
		p_bvalid	: out std_logic;
		p_bready	: in std_logic;
		p_araddr	: in std_logic_vector(C_P_ADDR_WIDTH-1 downto 0);
		p_arprot	: in std_logic_vector(2 downto 0);
		p_arvalid	: in std_logic;
		p_arready	: out std_logic;
		p_rdata	: out std_logic_vector(C_P_DATA_WIDTH-1 downto 0);
		p_rresp	: out std_logic_vector(1 downto 0);
		p_rvalid	: out std_logic;
		p_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface I
		i_aclk	: in std_logic;
		i_aresetn	: in std_logic;
		i_awaddr	: in std_logic_vector(C_I_ADDR_WIDTH-1 downto 0);
		i_awprot	: in std_logic_vector(2 downto 0);
		i_awvalid	: in std_logic;
		i_awready	: out std_logic;
		i_wdata	: in std_logic_vector(C_I_DATA_WIDTH-1 downto 0);
		i_wstrb	: in std_logic_vector((C_I_DATA_WIDTH/8)-1 downto 0);
		i_wvalid	: in std_logic;
		i_wready	: out std_logic;
		i_bresp	: out std_logic_vector(1 downto 0);
		i_bvalid	: out std_logic;
		i_bready	: in std_logic;
		i_araddr	: in std_logic_vector(C_I_ADDR_WIDTH-1 downto 0);
		i_arprot	: in std_logic_vector(2 downto 0);
		i_arvalid	: in std_logic;
		i_arready	: out std_logic;
		i_rdata	: out std_logic_vector(C_I_DATA_WIDTH-1 downto 0);
		i_rresp	: out std_logic_vector(1 downto 0);
		i_rvalid	: out std_logic;
		i_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface D
		d_aclk	: in std_logic;
		d_aresetn	: in std_logic;
		d_awaddr	: in std_logic_vector(C_D_ADDR_WIDTH-1 downto 0);
		d_awprot	: in std_logic_vector(2 downto 0);
		d_awvalid	: in std_logic;
		d_awready	: out std_logic;
		d_wdata	: in std_logic_vector(C_D_DATA_WIDTH-1 downto 0);
		d_wstrb	: in std_logic_vector((C_D_DATA_WIDTH/8)-1 downto 0);
		d_wvalid	: in std_logic;
		d_wready	: out std_logic;
		d_bresp	: out std_logic_vector(1 downto 0);
		d_bvalid	: out std_logic;
		d_bready	: in std_logic;
		d_araddr	: in std_logic_vector(C_D_ADDR_WIDTH-1 downto 0);
		d_arprot	: in std_logic_vector(2 downto 0);
		d_arvalid	: in std_logic;
		d_arready	: out std_logic;
		d_rdata	: out std_logic_vector(C_D_DATA_WIDTH-1 downto 0);
		d_rresp	: out std_logic_vector(1 downto 0);
		d_rvalid	: out std_logic;
		d_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface N
		n_aclk	: in std_logic;
		n_aresetn	: in std_logic;
		n_awaddr	: in std_logic_vector(C_N_ADDR_WIDTH-1 downto 0);
		n_awprot	: in std_logic_vector(2 downto 0);
		n_awvalid	: in std_logic;
		n_awready	: out std_logic;
		n_wdata	: in std_logic_vector(C_N_DATA_WIDTH-1 downto 0);
		n_wstrb	: in std_logic_vector((C_N_DATA_WIDTH/8)-1 downto 0);
		n_wvalid	: in std_logic;
		n_wready	: out std_logic;
		n_bresp	: out std_logic_vector(1 downto 0);
		n_bvalid	: out std_logic;
		n_bready	: in std_logic;
		n_araddr	: in std_logic_vector(C_N_ADDR_WIDTH-1 downto 0);
		n_arprot	: in std_logic_vector(2 downto 0);
		n_arvalid	: in std_logic;
		n_arready	: out std_logic;
		n_rdata	: out std_logic_vector(C_N_DATA_WIDTH-1 downto 0);
		n_rresp	: out std_logic_vector(1 downto 0);
		n_rvalid	: out std_logic;
		n_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S
		s_aclk	: in std_logic;
		s_aresetn	: in std_logic;
		s_awaddr	: in std_logic_vector(C_S_ADDR_WIDTH-1 downto 0);
		s_awprot	: in std_logic_vector(2 downto 0);
		s_awvalid	: in std_logic;
		s_awready	: out std_logic;
		s_wdata	: in std_logic_vector(C_S_DATA_WIDTH-1 downto 0);
		s_wstrb	: in std_logic_vector((C_S_DATA_WIDTH/8)-1 downto 0);
		s_wvalid	: in std_logic;
		s_wready	: out std_logic;
		s_bresp	: out std_logic_vector(1 downto 0);
		s_bvalid	: out std_logic;
		s_bready	: in std_logic;
		s_araddr	: in std_logic_vector(C_S_ADDR_WIDTH-1 downto 0);
		s_arprot	: in std_logic_vector(2 downto 0);
		s_arvalid	: in std_logic;
		s_arready	: out std_logic;
		s_rdata	: out std_logic_vector(C_S_DATA_WIDTH-1 downto 0);
		s_rresp	: out std_logic_vector(1 downto 0);
		s_rvalid	: out std_logic;
		s_rready	: in std_logic
	);
end pid_parameters_v1_0;

architecture arch_imp of pid_parameters_v1_0 is

	-- component declaration
	component pid_parameters_v1_0_P is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		p_out			: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
		);
	end component pid_parameters_v1_0_P;

	component pid_parameters_v1_0_I is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		i_out			: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
		);
	end component pid_parameters_v1_0_I;

	component pid_parameters_v1_0_D is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		d_out			: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
		);
	end component pid_parameters_v1_0_D;

	component pid_parameters_v1_0_N is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		n_out			: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
		);
	end component pid_parameters_v1_0_N;

	component pid_parameters_v1_0_S is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		s_out			: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
		);
	end component pid_parameters_v1_0_S;

begin

-- Instantiation of Axi Bus Interface P
pid_parameters_v1_0_P_inst : pid_parameters_v1_0_P
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_P_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_P_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> p_aclk,
		S_AXI_ARESETN	=> p_aresetn,
		S_AXI_AWADDR	=> p_awaddr,
		S_AXI_AWPROT	=> p_awprot,
		S_AXI_AWVALID	=> p_awvalid,
		S_AXI_AWREADY	=> p_awready,
		S_AXI_WDATA	=> p_wdata,
		S_AXI_WSTRB	=> p_wstrb,
		S_AXI_WVALID	=> p_wvalid,
		S_AXI_WREADY	=> p_wready,
		S_AXI_BRESP	=> p_bresp,
		S_AXI_BVALID	=> p_bvalid,
		S_AXI_BREADY	=> p_bready,
		S_AXI_ARADDR	=> p_araddr,
		S_AXI_ARPROT	=> p_arprot,
		S_AXI_ARVALID	=> p_arvalid,
		S_AXI_ARREADY	=> p_arready,
		S_AXI_RDATA	=> p_rdata,
		S_AXI_RRESP	=> p_rresp,
		S_AXI_RVALID	=> p_rvalid,
		S_AXI_RREADY	=> p_rready,
		p_out			=> p_out
	);

-- Instantiation of Axi Bus Interface I
pid_parameters_v1_0_I_inst : pid_parameters_v1_0_I
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_I_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_I_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> i_aclk,
		S_AXI_ARESETN	=> i_aresetn,
		S_AXI_AWADDR	=> i_awaddr,
		S_AXI_AWPROT	=> i_awprot,
		S_AXI_AWVALID	=> i_awvalid,
		S_AXI_AWREADY	=> i_awready,
		S_AXI_WDATA	=> i_wdata,
		S_AXI_WSTRB	=> i_wstrb,
		S_AXI_WVALID	=> i_wvalid,
		S_AXI_WREADY	=> i_wready,
		S_AXI_BRESP	=> i_bresp,
		S_AXI_BVALID	=> i_bvalid,
		S_AXI_BREADY	=> i_bready,
		S_AXI_ARADDR	=> i_araddr,
		S_AXI_ARPROT	=> i_arprot,
		S_AXI_ARVALID	=> i_arvalid,
		S_AXI_ARREADY	=> i_arready,
		S_AXI_RDATA	=> i_rdata,
		S_AXI_RRESP	=> i_rresp,
		S_AXI_RVALID	=> i_rvalid,
		S_AXI_RREADY	=> i_rready,
		i_out			=> i_out
	);

-- Instantiation of Axi Bus Interface D
pid_parameters_v1_0_D_inst : pid_parameters_v1_0_D
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_D_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_D_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> d_aclk,
		S_AXI_ARESETN	=> d_aresetn,
		S_AXI_AWADDR	=> d_awaddr,
		S_AXI_AWPROT	=> d_awprot,
		S_AXI_AWVALID	=> d_awvalid,
		S_AXI_AWREADY	=> d_awready,
		S_AXI_WDATA	=> d_wdata,
		S_AXI_WSTRB	=> d_wstrb,
		S_AXI_WVALID	=> d_wvalid,
		S_AXI_WREADY	=> d_wready,
		S_AXI_BRESP	=> d_bresp,
		S_AXI_BVALID	=> d_bvalid,
		S_AXI_BREADY	=> d_bready,
		S_AXI_ARADDR	=> d_araddr,
		S_AXI_ARPROT	=> d_arprot,
		S_AXI_ARVALID	=> d_arvalid,
		S_AXI_ARREADY	=> d_arready,
		S_AXI_RDATA	=> d_rdata,
		S_AXI_RRESP	=> d_rresp,
		S_AXI_RVALID	=> d_rvalid,
		S_AXI_RREADY	=> d_rready,
		d_out			=> d_out
	);

-- Instantiation of Axi Bus Interface N
pid_parameters_v1_0_N_inst : pid_parameters_v1_0_N
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_N_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_N_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> n_aclk,
		S_AXI_ARESETN	=> n_aresetn,
		S_AXI_AWADDR	=> n_awaddr,
		S_AXI_AWPROT	=> n_awprot,
		S_AXI_AWVALID	=> n_awvalid,
		S_AXI_AWREADY	=> n_awready,
		S_AXI_WDATA	=> n_wdata,
		S_AXI_WSTRB	=> n_wstrb,
		S_AXI_WVALID	=> n_wvalid,
		S_AXI_WREADY	=> n_wready,
		S_AXI_BRESP	=> n_bresp,
		S_AXI_BVALID	=> n_bvalid,
		S_AXI_BREADY	=> n_bready,
		S_AXI_ARADDR	=> n_araddr,
		S_AXI_ARPROT	=> n_arprot,
		S_AXI_ARVALID	=> n_arvalid,
		S_AXI_ARREADY	=> n_arready,
		S_AXI_RDATA	=> n_rdata,
		S_AXI_RRESP	=> n_rresp,
		S_AXI_RVALID	=> n_rvalid,
		S_AXI_RREADY	=> n_rready,
		n_out			=> n_out
	);

-- Instantiation of Axi Bus Interface S
pid_parameters_v1_0_S_inst : pid_parameters_v1_0_S
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> s_aclk,
		S_AXI_ARESETN	=> s_aresetn,
		S_AXI_AWADDR	=> s_awaddr,
		S_AXI_AWPROT	=> s_awprot,
		S_AXI_AWVALID	=> s_awvalid,
		S_AXI_AWREADY	=> s_awready,
		S_AXI_WDATA	=> s_wdata,
		S_AXI_WSTRB	=> s_wstrb,
		S_AXI_WVALID	=> s_wvalid,
		S_AXI_WREADY	=> s_wready,
		S_AXI_BRESP	=> s_bresp,
		S_AXI_BVALID	=> s_bvalid,
		S_AXI_BREADY	=> s_bready,
		S_AXI_ARADDR	=> s_araddr,
		S_AXI_ARPROT	=> s_arprot,
		S_AXI_ARVALID	=> s_arvalid,
		S_AXI_ARREADY	=> s_arready,
		S_AXI_RDATA	=> s_rdata,
		S_AXI_RRESP	=> s_rresp,
		S_AXI_RVALID	=> s_rvalid,
		S_AXI_RREADY	=> s_rready,
		s_out			=> s_out
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
