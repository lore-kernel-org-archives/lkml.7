Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F97206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mNX1wKho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCEAaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:30:10 -0500
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:20593
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbfCEAaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Taje/o7e6zbyPPjqsCzAAgR9JEc9DtFtPqRBoAZGM=;
 b=mNX1wKhoS5UjWIof4kvZv1NjyhZdEitReTu+6rcQ4o4JHdvUimWcMfQpvlU1S6CersL4IOhrAdaa5p4bg7ggJqlhfuRhA7awfv8PI3wlAsZINwns+NfgaWr38iPEJNIJ618KQt60kTGz4yw0zSBCzuETyVecwS09B8Yf9eLw4QM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1134.namprd22.prod.outlook.com (10.174.170.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 00:29:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1665.019; Tue, 5 Mar 2019
 00:29:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Main MIPS pull request for 5.1
Thread-Topic: [GIT PULL] Main MIPS pull request for 5.1
Thread-Index: AQHU0uqNNgYF265XUkeWrFWbGS7EQA==
Date:   Tue, 5 Mar 2019 00:29:53 +0000
Message-ID: <20190305002951.jdrcgn5jf5xoa5rr@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ef0231-cd0e-427f-5757-08d6a101af80
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1134;
x-ms-traffictypediagnostic: MWHPR2201MB1134:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjIyMDFNQjExMzQ7MjM6U05PRzlDeDk0S2FndW41MXZDRS9zdEJO?=
 =?utf-8?B?dS9hblV4Tk00bTBqRVljbSt6ZE5tVmNBZElzM0FLMVUxYkRZemk3WFY1am5s?=
 =?utf-8?B?bU0xWk9TZUpaNUI2Sk40Vy9nc2R4N0pxSjhoTlkrWWNuKzhIQVdnSXVNQW1t?=
 =?utf-8?B?Mm9QeTdFdjJUUnErdnBhaWdKTmJnK3dOTHQxZUJYcSs5cXluVFlJSVZ1d1p2?=
 =?utf-8?B?TWJiTmt0MjA2M3UweVFQL285b2tXaWRWMWF2NTJlT25hQ3gzbHlxV0pXeEpp?=
 =?utf-8?B?NFNvK0JKWDJYZFFIR1ZVRHlBMFBrR05ILzF3ZE5sOVNFcmoyM0MyRVRYT1ln?=
 =?utf-8?B?Ukx6R0U2Tm5oWGxkcldBZ3Q2by9GVW1GZDJod2IyUXc4SFVzWktxTGZRSTUx?=
 =?utf-8?B?Nnk0b2ZJd1ZreEdhYXd1c3FiTDdCREtZNElyRjF2QmdOcWgzNURqM3dDKzZL?=
 =?utf-8?B?RnFJd0xnWjdNY1dHWllhejVnU0EzZ2dvTVpPdnpCOUFObkZldEl0VHdYWVJJ?=
 =?utf-8?B?TzFHZlY4bkkxVDlUT3Q5emw2WnZzQkZyR0RBSWVBc2kwRUVSZDcxREREU1p0?=
 =?utf-8?B?cXEyc0NqVUN4UHJ5ck9rTWw2ZWJ5WEtYclQzZWhsTjlyaVpCTGtmMTZoMkVP?=
 =?utf-8?B?MHhlaW84MWRnSk9vbTJsRG1FUTNXUHdSYTFqaFFoTFBheTRkRzhLUDk0L2lH?=
 =?utf-8?B?S2xoWEJUeGJkaTZ5a05WbEtHK2NLVnNzWUdHSE5UMFlXaktHUU1FcVU3WEFN?=
 =?utf-8?B?L2FSUUkrWjJORkEveHJhcDVVUEM4K2lzOFovOTBlY2p6ZTIvcy80TkRvd3dH?=
 =?utf-8?B?d2xyR1VTTjdQcFVwSVYrdUVQc2xqZHhrR2gxakdVakd6WVVId1pVSktNQWlJ?=
 =?utf-8?B?OC9sZThpM2xRMmNtOHd6SUFTUm8wWEFoTE1JSytzVmxGdGJZOXFBcmhwWGJX?=
 =?utf-8?B?cE9ucUcvTTVpU09TZTNqcnVvQlp0YlIvdUhQTkVNMEZUZE96eHF4eXFPVWlP?=
 =?utf-8?B?dDQwUmNDY2tOMXlFTGVGQjZuR2QyeGVHQVZEY2JFMmlJYXI2ZTF0ZWcrS3Bm?=
 =?utf-8?B?V1lTd3VjTzJoanJvVjNCaU1XT1c4VDhzVHNaZjV4UWU4aFVaZzFsOTFMNUlW?=
 =?utf-8?B?WGlTMjJCYVNrWUFLMmRWSHRnRmVJUUNjTWZwbmZiQTgxZ05FK250dm12bEpp?=
 =?utf-8?B?bGczZEVPR1lpUzBlTGNkZjRMY3Z4NW40TjVIa3JKMjBqeEt4Qi9SY3VqSGRi?=
 =?utf-8?B?L0JwM2YvZk9FODZ0NHREckFsckR2eXF2b2tDb3MvMVkwanNIT2x2Wmw1SndL?=
 =?utf-8?B?cWNGTDNwOEtGeUFvUG1ja1JVMk1QMlZsRlhXYXk5UHhQZTFtNzVjelc4MFJH?=
 =?utf-8?B?a3hvZEU2S1FQTDdVN2ttQXllU21memgxYnh0UmExNVZ1a1ZDbGdhYTVIV01O?=
 =?utf-8?B?T3FlQyt6b1BnUTJwSHlSSEt3WjJ1RTVVVTljOTZaclVJSWxsNE9Uem9WRVBt?=
 =?utf-8?B?Q2p0VEcyemVhSmk2MUk0SkovN0I3NlZNeG03am9oT2gxMGNtbnpwYzNIZXZF?=
 =?utf-8?B?cFZPcE4zelRHeHZBNjJHMHVnTitVZjFOY3BQWXI2R2owdzMxYkdqTVpRU1U4?=
 =?utf-8?B?VU9kaFdlNldOb0x2ZDFOZzA3Lzl6ZFRaM1VUSUFmSmJTcVJBd2IzU0lDbUJh?=
 =?utf-8?Q?idLOKJjnbmvpqFZnOkKndVRYA2lx89zUcV2EoQ9SI?=
x-microsoft-antispam-prvs: <MWHPR2201MB113498FEA02F3595C7EB8509C1720@MWHPR2201MB1134.namprd22.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(39850400004)(136003)(366004)(396003)(189003)(199004)(486006)(6486002)(8676002)(81166006)(99286004)(81156014)(6916009)(66066001)(6512007)(26005)(58126008)(316002)(9686003)(476003)(186003)(42882007)(6436002)(52116002)(256004)(14444005)(102836004)(305945005)(6506007)(105586002)(386003)(68736007)(54906003)(8936002)(99936001)(106356001)(25786009)(7736002)(5660300002)(1076003)(97736004)(66574012)(14454004)(2906002)(4326008)(53936002)(71200400001)(30864003)(71190400001)(3846002)(6116002)(44832011)(33716001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1134;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iNczrZ4gpPPfNDP9zEeTpXYV7GWsyNU73KF4Wh3Eq+YevP4b0k+8P3isyRnB986MyUtT91q7ou0RJEUMg4+6d7Y6P4L/HZ2dGxTQz2XAFE6C7vVJEaag04U3T7sV0PLt0+ChSKuNrERIF6xRaQQNB04QuIT1N0DfjIOWPKMyOxZXxlD2LzysUq2nHrijya4d+wbNQYtvxz6xBp46VBRSHuYe6mnxtWHv8pcjLBfNbbPtQSwFGypbNf1O7G4HuJgC45vAcIMDoElDZrCGm9osRIKQ8ClSm74eBgGxiRmxoAr1yiEO5OjfDwLenwGrcr/Zey0g0eBBoALWnvkGiUr9ja5adhm1YPicD/eMVhQrQh0BvDz5Og8U+z7T0WFJnrfCL1y/6decRhLxe8lu9gfM8DfO85iJ+gw7geEqwJxXgqM=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rzyzhq33cqcmpch2"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ef0231-cd0e-427f-5757-08d6a101af80
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 00:29:53.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--rzyzhq33cqcmpch2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Below are the main MIPS changes for v5.1; please pull.

Thanks,
    Paul


The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.1

for you to fetch changes up to aeb669d41ffabb91b1542f1f802cb12a989fced0:

  MIPS: lantiq: Remove separate GPHY Firmware loader (2019-02-25 14:17:10 -=
0800)

----------------------------------------------------------------
Here's the main MIPS pull request for v5.1:

- Support for the MIPSr6 MemoryMapID register & Global INValidate TLB
  (GINVT) instructions, allowing for more efficient TLB maintenance when
  running on a CPU such as the I6500 that supports these.

- Enable huge page support for MIPS64r6.

- Optimize post-DMA cache sync by removing that code entirely for kernel
  configurations in which we know it won't be needed.

- The number of pages allocated for interrupt stacks is now calculated
  correctly, where before we would wastefully allocate too much memory
  in some configurations.

- The ath79 platform migrates to devicetree.

- The bcm47xx platform sees fixes for the Buffalo WHR-G54S board.

- The ingenic/jz4740 platform gains support for appended devicetrees.

- The cavium_octeon, lantiq, loongson32 & sgi-ip27 platforms all see
  cleanups as do various pieces of core architecture code.

----------------------------------------------------------------
Aaro Koskinen (7):
      MIPS: OCTEON: delete SMI/MDIO enable
      MIPS: OCTEON: delete unused cvmx-smix-defs.h
      MIPS: OCTEON: add fixed-link nodes to in-kernel device tree
      MIPS: OCTEON: warn if deprecated link status is being used
      MIPS: OCTEON: don't lie about interface type of CN3005 board
      MIPS: OCTEON: delete board-specific link status
      MIPS: OCTEON: program rx/tx-delay always from DT

Felix Fietkau (6):
      MIPS: ath79: add helpers for setting clocks and expose the ref clock
      MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc in=
it
      MIPS: ath79: pass PLL base to clock init functions
      MIPS: ath79: make specifying the reference clock in DT optional
      MIPS: ath79: support setting up clock via DT on all SoC types
      MIPS: ath79: export switch MDIO reference clock

Greg Kroah-Hartman (5):
      mips: cavium: no need to check return value of debugfs_create functio=
ns
      mips: ralink: no need to check return value of debugfs_create functio=
ns
      mips: mm: no need to check return value of debugfs_create functions
      mips: math-emu: no need to check return value of debugfs_create funct=
ions
      mips: kernel: no need to check return value of debugfs_create functio=
ns

Hauke Mehrtens (2):
      MIPS: Compile post DMA flush only when needed
      MIPS: lantiq: Remove separate GPHY Firmware loader

Jiaxun Yang (5):
      MIPS: Loongson32: Remove unused platform devices
      MIPS: Loongson32: clarify we don't support MIPS16 and merge configs
      MIPS: Loongson32: Set load address to 0x80200000
      MIPS: Loongson32: workaround di issue
      MIPS: Loongson32: Revert ISA level to MIPS32R2

John Crispin (5):
      MIPS: ath79: drop legacy IRQ code
      MIPS: ath79: drop machfiles
      MIPS: ath79: drop legacy pci code
      MIPS: ath79: drop platform device registration code
      MIPS: ath79: drop !OF clock code

Liu Xiang (1):
      MIPS: irq: Allocate accurate order pages for irq stack

Masahiro Yamada (1):
      MIPS: remove meaningless generic-(CONFIG_GENERIC_CSUM) +=3D checksum.h

Paul Burton (26):
      MIPS: mm: Define activate_mm() using switch_mm()
      MIPS: mm: Remove redundant drop_mmu_context() cpu argument
      MIPS: mm: Remove redundant get_new_mmu_context() cpu argument
      MIPS: mm: Avoid HTW stop/start when dropping an inactive mm
      MIPS: mm: Consolidate drop_mmu_context() has-ASID checks
      MIPS: mm: Move drop_mmu_context() comment into appropriate block
      MIPS: mm: Remove redundant preempt_disable in local_flush_tlb_mm()
      MIPS: mm: Remove local_flush_tlb_mm()
      MIPS: mm: Split obj-y to a file per line
      MIPS: mm: Un-inline get_new_mmu_context
      MIPS: mm: Unify ASID version checks
      MIPS: mm: Add set_cpu_context() for ASID assignments
      MIPS: Add GINVT instruction helpers
      MIPS: MemoryMapID (MMID) Support
      MIPS: Remove open-coded cmpxchg() in set_pte()
      MIPS: Enable hugepage support for MIPS64r6
      MIPS: Don't select ARCH_HAS_SYNC_DMA_FOR_CPU when DMA is coherent
      MIPS: Loongson32: Fix config brokenness; select SYS_SUPPORTS_32BIT_KE=
RNEL
      MIPS: Loongson32: Remove DMA & NAND devices from ls1b/board.c
      MIPS: Export mm switching functions used by KVM
      MIPS: Fix set_pte() for Netlogic XLR using cmpxchg64()
      MIPS: Delete unused flush_cache_sigtramp()
      MIPS: CM: Fix indentation
      MIPS: eBPF: Always return sign extended 32b values
      MIPS: eBPF: Remove REG_32BIT_ZERO_EX
      MIPS: dma-noncoherent: Remove bogus condition in dma_sync_phys()

Paul Cercueil (1):
      MIPS: ingenic: Add support for appended devicetree

Rafa=C5=82 Mi=C5=82ecki (1):
      MIPS: BCM47XX: Fix/improve Buffalo WHR-G54S support

Thomas Bogendoerfer (6):
      MIPS: SGI-IP27: get rid of volatile and hubreg_t
      MIPS: SGI-IP27: clean up bridge access and header files
      MIPS: SGI-IP27: use pr_info/pr_emerg and pr_cont to fix output
      MIPS: SGI-IP27: do xtalk scanning later
      MIPS: SGI-IP27: do boot CPU init later
      MIPS: SGI-IP27: rework HUB interrupts

 .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 ---
 .../devicetree/bindings/mips/lantiq/rcu.txt        |  18 --
 arch/mips/Kconfig                                  |  13 +-
 arch/mips/Makefile                                 |   2 +
 arch/mips/ath79/Kconfig                            |  73 -----
 arch/mips/ath79/Makefile                           |  23 +-
 arch/mips/ath79/clock.c                            | 342 +++++++++--------=
---
 arch/mips/ath79/common.h                           |   5 -
 arch/mips/ath79/dev-common.c                       | 159 ---------
 arch/mips/ath79/dev-common.h                       |  18 --
 arch/mips/ath79/dev-gpio-buttons.c                 |  56 ----
 arch/mips/ath79/dev-gpio-buttons.h                 |  23 --
 arch/mips/ath79/dev-leds-gpio.c                    |  54 ----
 arch/mips/ath79/dev-leds-gpio.h                    |  21 --
 arch/mips/ath79/dev-spi.c                          |  38 ---
 arch/mips/ath79/dev-spi.h                          |  22 --
 arch/mips/ath79/dev-usb.c                          | 242 --------------
 arch/mips/ath79/dev-usb.h                          |  17 -
 arch/mips/ath79/dev-wmac.c                         | 155 ---------
 arch/mips/ath79/dev-wmac.h                         |  17 -
 arch/mips/ath79/irq.c                              | 169 ----------
 arch/mips/ath79/mach-ap121.c                       |  92 ------
 arch/mips/ath79/mach-ap136.c                       | 156 ---------
 arch/mips/ath79/mach-ap81.c                        | 100 ------
 arch/mips/ath79/mach-db120.c                       | 136 --------
 arch/mips/ath79/mach-pb44.c                        | 128 --------
 arch/mips/ath79/mach-ubnt-xm.c                     | 126 --------
 arch/mips/ath79/machtypes.h                        |  28 --
 arch/mips/ath79/pci.c                              | 273 ----------------
 arch/mips/ath79/pci.h                              |  35 --
 arch/mips/ath79/setup.c                            |  78 +----
 arch/mips/bcm47xx/buttons.c                        |   2 +-
 arch/mips/bcm47xx/leds.c                           |  10 +-
 arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts   |  14 +
 arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts     |   6 +
 .../cavium-octeon/executive/cvmx-helper-board.c    |  86 +----
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  39 +--
 arch/mips/cavium-octeon/oct_ilm.c                  |  32 +-
 arch/mips/cavium-octeon/octeon-platform.c          |  64 ++++
 arch/mips/configs/xway_defconfig                   |   1 -
 arch/mips/include/asm/Kbuild                       |   1 -
 arch/mips/include/asm/barrier.h                    |  19 ++
 arch/mips/include/asm/cacheflush.h                 |   2 -
 arch/mips/include/asm/cmpxchg.h                    | 104 +++++-
 arch/mips/include/asm/cpu-features.h               |  13 +
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/ginvt.h                      |  56 ++++
 arch/mips/include/asm/irqflags.h                   |   2 +-
 arch/mips/include/asm/mach-ath79/ath79.h           |   4 -
 arch/mips/include/asm/mach-ip27/irq.h              |  12 +-
 arch/mips/include/asm/mach-ip27/mmzone.h           |   9 -
 arch/mips/include/asm/mach-loongson32/platform.h   |   4 -
 arch/mips/include/asm/mipsregs.h                   |  11 +
 arch/mips/include/asm/mmu.h                        |   6 +-
 arch/mips/include/asm/mmu_context.h                | 139 ++++----
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |  12 -
 arch/mips/include/asm/octeon/cvmx-smix-defs.h      | 276 ----------------
 arch/mips/include/asm/pci/bridge.h                 | 206 ++++++------
 arch/mips/include/asm/pgtable.h                    |  49 +--
 arch/mips/include/asm/smp-ops.h                    |   1 +
 arch/mips/include/asm/sn/addrs.h                   |  72 +----
 arch/mips/include/asm/sn/arch.h                    |   2 -
 arch/mips/include/asm/sn/io.h                      |   2 +-
 arch/mips/include/asm/sn/sn0/addrs.h               |   5 -
 arch/mips/include/asm/tlbflush.h                   |   5 +-
 arch/mips/jz4740/setup.c                           |  14 +-
 arch/mips/kernel/cpu-probe.c                       |  55 +++-
 arch/mips/kernel/irq.c                             |   4 +-
 arch/mips/kernel/mips-cm.c                         |   4 +-
 arch/mips/kernel/mips-r2-to-r6-emul.c              |  21 +-
 arch/mips/kernel/segment.c                         |  15 +-
 arch/mips/kernel/setup.c                           |   7 +-
 arch/mips/kernel/smp.c                             |  69 +++-
 arch/mips/kernel/spinlock_test.c                   |  21 +-
 arch/mips/kernel/traps.c                           |   4 +-
 arch/mips/kernel/unaligned.c                       |  17 +-
 arch/mips/kvm/emulate.c                            |   8 +-
 arch/mips/kvm/mips.c                               |   5 +
 arch/mips/kvm/trap_emul.c                          |  30 +-
 arch/mips/kvm/vz.c                                 |   8 +-
 arch/mips/lantiq/Kconfig                           |   4 -
 arch/mips/lib/dump_tlb.c                           |  22 +-
 arch/mips/loongson32/Kconfig                       |   2 -
 arch/mips/loongson32/Platform                      |   4 +-
 arch/mips/loongson32/common/platform.c             |  63 ----
 arch/mips/loongson32/ls1b/board.c                  |  28 --
 arch/mips/math-emu/me-debugfs.c                    |  23 +-
 arch/mips/mm/Makefile                              |  16 +-
 arch/mips/mm/c-octeon.c                            |  18 --
 arch/mips/mm/c-r3k.c                               |  25 --
 arch/mips/mm/c-r4k.c                               | 124 +------
 arch/mips/mm/c-tx39.c                              |  21 --
 arch/mips/mm/cache.c                               |   1 -
 arch/mips/mm/context.c                             | 291 +++++++++++++++++
 arch/mips/mm/dma-noncoherent.c                     |   9 +-
 arch/mips/mm/init.c                                |   7 +
 arch/mips/mm/sc-debugfs.c                          |  15 +-
 arch/mips/mm/tlb-r3k.c                             |  14 +-
 arch/mips/mm/tlb-r4k.c                             |  71 ++--
 arch/mips/mm/tlb-r8k.c                             |  10 +-
 arch/mips/net/ebpf_jit.c                           |  24 +-
 arch/mips/pci/Makefile                             |   1 +
 arch/mips/pci/fixup-ath79.c                        |  21 ++
 arch/mips/pci/ops-bridge.c                         |  68 ++--
 arch/mips/pci/pci-ip27.c                           |  49 +--
 arch/mips/ralink/bootrom.c                         |   8 +-
 arch/mips/sgi-ip27/Makefile                        |   3 +-
 arch/mips/sgi-ip27/ip27-hubio.c                    |   4 +-
 arch/mips/sgi-ip27/ip27-init.c                     |  39 +--
 arch/mips/sgi-ip27/ip27-irq-pci.c                  | 266 ---------------
 arch/mips/sgi-ip27/ip27-irq.c                      | 357 ++++++++++++++---=
----
 arch/mips/sgi-ip27/ip27-irqno.c                    |  48 ---
 arch/mips/sgi-ip27/ip27-memory.c                   |  34 +-
 arch/mips/sgi-ip27/ip27-nmi.c                      |  64 ++--
 arch/mips/sgi-ip27/ip27-smp.c                      |   5 +-
 arch/mips/sgi-ip27/ip27-timer.c                    |  42 +--
 arch/mips/sgi-ip27/ip27-xtalk.c                    |  13 +-
 drivers/soc/lantiq/Makefile                        |   1 -
 drivers/soc/lantiq/gphy.c                          | 224 -------------
 include/dt-bindings/clock/ath79-clk.h              |   4 +-
 120 files changed, 1622 insertions(+), 4625 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.=
txt
 delete mode 100644 arch/mips/ath79/dev-common.c
 delete mode 100644 arch/mips/ath79/dev-common.h
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.c
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.h
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.c
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.h
 delete mode 100644 arch/mips/ath79/dev-spi.c
 delete mode 100644 arch/mips/ath79/dev-spi.h
 delete mode 100644 arch/mips/ath79/dev-usb.c
 delete mode 100644 arch/mips/ath79/dev-usb.h
 delete mode 100644 arch/mips/ath79/dev-wmac.c
 delete mode 100644 arch/mips/ath79/dev-wmac.h
 delete mode 100644 arch/mips/ath79/irq.c
 delete mode 100644 arch/mips/ath79/mach-ap121.c
 delete mode 100644 arch/mips/ath79/mach-ap136.c
 delete mode 100644 arch/mips/ath79/mach-ap81.c
 delete mode 100644 arch/mips/ath79/mach-db120.c
 delete mode 100644 arch/mips/ath79/mach-pb44.c
 delete mode 100644 arch/mips/ath79/mach-ubnt-xm.c
 delete mode 100644 arch/mips/ath79/machtypes.h
 delete mode 100644 arch/mips/ath79/pci.c
 delete mode 100644 arch/mips/ath79/pci.h
 create mode 100644 arch/mips/include/asm/ginvt.h
 delete mode 100644 arch/mips/include/asm/octeon/cvmx-smix-defs.h
 create mode 100644 arch/mips/mm/context.c
 create mode 100644 arch/mips/pci/fixup-ath79.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-irq-pci.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-irqno.c
 delete mode 100644 drivers/soc/lantiq/gphy.c

--rzyzhq33cqcmpch2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXH3C/wAKCRA+p5+stXUA
3XTjAP4zZcrsKlv4rsyqNZXbtcgqApnoDKDn2Tf/1SgDQORV0gEAlw9HSjejaN6n
mTZYTzOuycQ9+7RdPyrVYg7wHqV8TQk=
=WgWI
-----END PGP SIGNATURE-----

--rzyzhq33cqcmpch2--
