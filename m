Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E803C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336722317
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKSCH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:07:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:21081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfKSCH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:07:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 18:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="gz'50?scan'50,208,50";a="406295294"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2019 18:07:50 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iWsvm-0003IQ-CD; Tue, 19 Nov 2019 10:07:50 +0800
Date:   Tue, 19 Nov 2019 10:07:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:WIP.x86/cleanups 2/3] arch/x86/kernel/setup.c:1199:2: error:
 implicit declaration of function 'io_apic_init_mappings'; did you mean
 'irq_find_mapping'?
Message-ID: <201911191040.6ynYdzrJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ckcmygq6i5dsp7zy"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ckcmygq6i5dsp7zy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/cleanups
head:   9dcc69c4ea5c0cd4031a4dde645c71b66bea04f8
commit: c1877650f3c9fb8568f8dce3fc804ab45125cf78 [2/3] x86/setup: Clean up the header portion of setup.c
config: i386-randconfig-a002-20191117 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        git checkout c1877650f3c9fb8568f8dce3fc804ab45125cf78
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/setup.c: In function 'setup_arch':
   arch/x86/kernel/setup.c:1173:2: error: implicit declaration of function 'generic_apic_probe'; did you mean 'generic_drop_inode'? [-Werror=implicit-function-declaration]
     generic_apic_probe();
     ^~~~~~~~~~~~~~~~~~
     generic_drop_inode
   arch/x86/kernel/setup.c:1193:2: error: implicit declaration of function 'init_apic_mappings'; did you mean 'init_mem_mapping'? [-Werror=implicit-function-declaration]
     init_apic_mappings();
     ^~~~~~~~~~~~~~~~~~
     init_mem_mapping
>> arch/x86/kernel/setup.c:1199:2: error: implicit declaration of function 'io_apic_init_mappings'; did you mean 'irq_find_mapping'? [-Werror=implicit-function-declaration]
     io_apic_init_mappings();
     ^~~~~~~~~~~~~~~~~~~~~
     irq_find_mapping
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
   Cyclomatic Complexity 1 arch/x86/include/asm/page_types.h:get_max_mapped
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/irqflags.h:native_save_fl
   Cyclomatic Complexity 1 arch/x86/include/asm/irqflags.h:arch_local_save_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/irqflags.h:arch_irqs_disabled_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/special_insns.h:native_write_cr3
   Cyclomatic Complexity 1 arch/x86/include/asm/special_insns.h:native_read_cr4
   Cyclomatic Complexity 1 arch/x86/include/asm/special_insns.h:__read_cr4
   Cyclomatic Complexity 1 arch/x86/include/asm/special_insns.h:write_cr3
   Cyclomatic Complexity 1 arch/x86/include/asm/processor.h:load_cr3
   Cyclomatic Complexity 3 arch/x86/include/asm/cpufeature.h:_static_cpu_has
   Cyclomatic Complexity 1 arch/x86/include/asm/preempt.h:preempt_count
   Cyclomatic Complexity 1 arch/x86/include/asm/numa.h:init_cpu_to_node
   Cyclomatic Complexity 1 arch/x86/include/asm/mpspec.h:get_smp_config
   Cyclomatic Complexity 1 arch/x86/include/asm/mpspec.h:find_smp_config
   Cyclomatic Complexity 1 arch/x86/include/asm/mpspec.h:e820__memblock_alloc_reserved_mpc_new
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:__flush_tlb
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:__flush_tlb_global
   Cyclomatic Complexity 1 arch/x86/include/asm/desc.h:idt_setup_early_pf
   Cyclomatic Complexity 1 arch/x86/include/asm/pgtable.h:ptr_set_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/pgtable.h:kernel_to_user_pgdp
   Cyclomatic Complexity 1 include/linux/kdev_t.h:old_decode_dev
   Cyclomatic Complexity 1 include/linux/dmi.h:dmi_setup
   Cyclomatic Complexity 1 include/linux/efi.h:efi_esrt_init
   Cyclomatic Complexity 1 include/linux/efi.h:efi_fake_memmap
   Cyclomatic Complexity 1 include/linux/efi.h:efi_enabled
   Cyclomatic Complexity 1 include/linux/iscsi_ibft.h:find_ibft_region
   Cyclomatic Complexity 1 include/linux/dma-contiguous.h:dma_contiguous_reserve
   Cyclomatic Complexity 1 include/linux/usb/xhci-dbgp.h:early_xdbc_setup_hardware
   Cyclomatic Complexity 1 include/linux/usb/xhci-dbgp.h:early_xdbc_register_console
   Cyclomatic Complexity 1 arch/x86/include/asm/cpu.h:prefill_possible_map
   Cyclomatic Complexity 1 arch/x86/include/asm/mpx.h:mpx_mm_init
   Cyclomatic Complexity 1 arch/x86/include/asm/efi.h:parse_efi_setup
   Cyclomatic Complexity 1 arch/x86/include/asm/kasan.h:kasan_init
   Cyclomatic Complexity 1 arch/x86/include/asm/kaslr.h:kernel_randomize_memory
   Cyclomatic Complexity 1 arch/x86/include/asm/mce.h:mcheck_init
   Cyclomatic Complexity 1 arch/x86/include/asm/olpc_ofw.h:olpc_ofw_detect
   Cyclomatic Complexity 1 arch/x86/include/asm/olpc_ofw.h:setup_olpc_ofw_pgd
   Cyclomatic Complexity 1 arch/x86/include/asm/setup.h:vsmp_init
   Cyclomatic Complexity 1 arch/x86/include/asm/setup.h:kaslr_enabled
   Cyclomatic Complexity 1 arch/x86/include/asm/setup.h:kaslr_offset
   Cyclomatic Complexity 1 arch/x86/include/asm/prom.h:add_dtb
   Cyclomatic Complexity 1 arch/x86/include/asm/prom.h:x86_dtb_init
   Cyclomatic Complexity 1 arch/x86/include/asm/unwind.h:unwind_init
   Cyclomatic Complexity 1 arch/x86/include/asm/vsyscall.h:map_vsyscall
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:copy_edd
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:cleanup_highmap
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:get_ramdisk_image
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:get_ramdisk_size
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:reserve_crashkernel
   Cyclomatic Complexity 2 include/asm-generic/bitops-instrumented.h:test_bit
   Cyclomatic Complexity 7 arch/x86/include/asm/tlbflush.h:__flush_tlb_all
   Cyclomatic Complexity 10 arch/x86/kernel/setup.c:parse_reservelow
   Cyclomatic Complexity 9 arch/x86/kernel/setup.c:early_reserve_initrd
   Cyclomatic Complexity 4 arch/x86/kernel/setup.c:reserve_ibft_region
   Cyclomatic Complexity 4 arch/x86/kernel/setup.c:reserve_brk
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:trim_low_memory_range
   Cyclomatic Complexity 3 arch/x86/kernel/setup.c:dump_kernel_offset
   Cyclomatic Complexity 3 arch/x86/include/asm/pgtable.h:clone_pgd_range
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:memblock_x86_reserve_range_setup_data
   Cyclomatic Complexity 5 arch/x86/kernel/setup.c:parse_setup_data
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:trim_bios_range
   Cyclomatic Complexity 3 arch/x86/kernel/setup.c:e820_add_kernel_range
   Cyclomatic Complexity 10 arch/x86/kernel/setup.c:snb_gfx_workaround_needed
   Cyclomatic Complexity 6 arch/x86/kernel/setup.c:trim_snb_memory
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:trim_platform_memory_ranges
   Cyclomatic Complexity 3 arch/x86/kernel/setup.c:relocate_initrd
   Cyclomatic Complexity 13 arch/x86/kernel/setup.c:reserve_initrd
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:register_kernel_offset_dumper
   Cyclomatic Complexity 4 arch/x86/kernel/setup.c:extend_brk
   Cyclomatic Complexity 2 arch/x86/kernel/setup.c:reserve_standard_io_resources
   Cyclomatic Complexity 25 arch/x86/kernel/setup.c:setup_arch
   Cyclomatic Complexity 1 arch/x86/kernel/setup.c:i386_reserve_resources
   cc1: some warnings being treated as errors

vim +1199 arch/x86/kernel/setup.c

72d7c3b33c9808 arch/x86/kernel/setup.c    Yinghai Lu       2010-08-25  1078  
4f7b92263ad68c arch/x86/kernel/setup.c    Yinghai Lu       2013-01-24  1079  	reserve_real_mode();
893f38d144a4d9 arch/x86/kernel/setup.c    Yinghai Lu       2009-12-10  1080  
a9acc5365dbda2 arch/x86/kernel/setup.c    Jesse Barnes     2012-11-14  1081  	trim_platform_memory_ranges();
95c9608478d639 arch/x86/kernel/setup.c    H. Peter Anvin   2013-02-14  1082  	trim_low_memory_range();
a9acc5365dbda2 arch/x86/kernel/setup.c    Jesse Barnes     2012-11-14  1083  
22ddfcaa0dbae9 arch/x86/kernel/setup.c    Yinghai Lu       2012-11-16  1084  	init_mem_mapping();
1bbbbe779aabe1 arch/x86/kernel/setup.c    Jacob Shin       2011-10-20  1085  
433f8924fa8e55 arch/x86/kernel/setup.c    Thomas Gleixner  2017-08-28  1086  	idt_setup_early_pf();
1bbbbe779aabe1 arch/x86/kernel/setup.c    Jacob Shin       2011-10-20  1087  
18bc7bd523e0fc arch/x86/kernel/setup.c    Andy Lutomirski  2016-08-10  1088  	/*
18bc7bd523e0fc arch/x86/kernel/setup.c    Andy Lutomirski  2016-08-10  1089  	 * Update mmu_cr4_features (and, indirectly, trampoline_cr4_features)
18bc7bd523e0fc arch/x86/kernel/setup.c    Andy Lutomirski  2016-08-10  1090  	 * with the current CR4 value.  This may not be necessary, but
18bc7bd523e0fc arch/x86/kernel/setup.c    Andy Lutomirski  2016-08-10  1091  	 * auditing all the early-boot CR4 manipulation would be needed to
18bc7bd523e0fc arch/x86/kernel/setup.c    Andy Lutomirski  2016-08-10  1092  	 * rule it out.
c7ad5ad297e644 arch/x86/kernel/setup.c    Andy Lutomirski  2017-09-10  1093  	 *
c7ad5ad297e644 arch/x86/kernel/setup.c    Andy Lutomirski  2017-09-10  1094  	 * Mask off features that don't work outside long mode (just
c7ad5ad297e644 arch/x86/kernel/setup.c    Andy Lutomirski  2017-09-10  1095  	 * PCIDE for now).
18bc7bd523e0fc arch/x86/kernel/setup.c    Andy Lutomirski  2016-08-10  1096  	 */
c7ad5ad297e644 arch/x86/kernel/setup.c    Andy Lutomirski  2017-09-10  1097  	mmu_cr4_features = __read_cr4() & ~X86_CR4_PCIDE;
18bc7bd523e0fc arch/x86/kernel/setup.c    Andy Lutomirski  2016-08-10  1098  
4ce7a8697cb795 arch/x86/kernel/setup.c    Yinghai Lu       2014-01-27  1099  	memblock_set_current_limit(get_max_mapped());
4e29684c40f2a3 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-24  1100  
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1101  	/*
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1102  	 * NOTE: On x86-32, only from this point on, fixmaps are ready for use.
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1103  	 */
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1104  
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1105  #ifdef CONFIG_PROVIDE_OHCI1394_DMA_INIT
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1106  	if (init_ohci1394_dma_early)
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1107  		init_ohci1394_dma_on_all_controllers();
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1108  #endif
162a7e7500f966 arch/x86/kernel/setup.c    Mike Travis      2011-05-24  1109  	/* Allocate bigger log buffer */
162a7e7500f966 arch/x86/kernel/setup.c    Mike Travis      2011-05-24  1110  	setup_log_buf(1);
e7b3789524eecc arch/x86/kernel/setup.c    Yinghai Lu       2008-06-25  1111  
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1112  	if (efi_enabled(EFI_BOOT)) {
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1113  		switch (boot_params.secure_boot) {
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1114  		case efi_secureboot_mode_disabled:
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1115  			pr_info("Secure boot disabled\n");
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1116  			break;
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1117  		case efi_secureboot_mode_enabled:
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1118  			pr_info("Secure boot enabled\n");
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1119  			break;
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1120  		default:
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1121  			pr_info("Secure boot could not be determined\n");
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1122  			break;
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1123  		}
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1124  	}
9661b332041dab arch/x86/kernel/setup.c    David Howells    2017-02-06  1125  
2ec65f8b89ea00 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1126  	reserve_initrd();
2ec65f8b89ea00 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1127  
da3d3f98d28bc0 arch/x86/kernel/setup.c    Aleksey Makarov  2016-06-20  1128  	acpi_table_upgrade();
53aac44c904abb arch/x86/kernel/setup.c    Thomas Renninger 2012-10-01  1129  
76934ed4b33b65 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-25  1130  	vsmp_init();
76934ed4b33b65 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-25  1131  
1c6e55032e24ff arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-17  1132  	io_delay_init();
1c6e55032e24ff arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-17  1133  
630b3aff8a51c9 arch/x86/kernel/setup.c    Lukas Wunner     2017-08-01  1134  	early_platform_quirks();
630b3aff8a51c9 arch/x86/kernel/setup.c    Lukas Wunner     2017-08-01  1135  
1c6e55032e24ff arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-17  1136  	/*
1c6e55032e24ff arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-17  1137  	 * Parse the ACPI tables for possible boot-time SMP configuration.
1c6e55032e24ff arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-17  1138  	 */
20e6926dcbafa1 arch/x86/kernel/setup.c    Yinghai Lu       2013-03-01  1139  	acpi_boot_table_init();
20e6926dcbafa1 arch/x86/kernel/setup.c    Yinghai Lu       2013-03-01  1140  
20e6926dcbafa1 arch/x86/kernel/setup.c    Yinghai Lu       2013-03-01  1141  	early_acpi_boot_init();
20e6926dcbafa1 arch/x86/kernel/setup.c    Yinghai Lu       2013-03-01  1142  
d8fc3afc49bb22 arch/x86/kernel/setup.c    Tejun Heo        2011-02-16  1143  	initmem_init();
3c325f8233c35f arch/x86/kernel/setup.c    Weijie Yang      2014-10-24  1144  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
fa591c4ae76ecb arch/x86/kernel/setup.c    Tang Chen        2013-11-12  1145  
fa591c4ae76ecb arch/x86/kernel/setup.c    Tang Chen        2013-11-12  1146  	/*
fa591c4ae76ecb arch/x86/kernel/setup.c    Tang Chen        2013-11-12  1147  	 * Reserve memory for crash kernel after SRAT is parsed so that it
fa591c4ae76ecb arch/x86/kernel/setup.c    Tang Chen        2013-11-12  1148  	 * won't consume hotpluggable memory.
fa591c4ae76ecb arch/x86/kernel/setup.c    Tang Chen        2013-11-12  1149  	 */
fa591c4ae76ecb arch/x86/kernel/setup.c    Tang Chen        2013-11-12  1150  	reserve_crashkernel();
fa591c4ae76ecb arch/x86/kernel/setup.c    Tang Chen        2013-11-12  1151  
6f2a75369e7561 arch/x86/kernel/setup.c    Yinghai Lu       2010-08-25  1152  	memblock_find_dma_reserve();
91467bdf6e5305 arch/x86/kernel/setup.c    Bernhard Walle   2008-07-18  1153  
ccb64941f375a6 arch/x86/kernel/setup.c    Boris Ostrovsky  2017-09-11  1154  	if (!early_xdbc_setup_hardware())
ccb64941f375a6 arch/x86/kernel/setup.c    Boris Ostrovsky  2017-09-11  1155  		early_xdbc_register_console();
ccb64941f375a6 arch/x86/kernel/setup.c    Boris Ostrovsky  2017-09-11  1156  
7737b215ad0f94 arch/x86/kernel/setup.c    Attilio Rao      2012-08-21  1157  	x86_init.paging.pagetable_init();
f212ec4b7b4d84 arch/x86/kernel/setup_32.c Bernhard Kaindl  2008-01-30  1158  
ef7f0d6a6ca8c9 arch/x86/kernel/setup.c    Andrey Ryabinin  2015-02-13  1159  	kasan_init();
ef7f0d6a6ca8c9 arch/x86/kernel/setup.c    Andrey Ryabinin  2015-02-13  1160  
d2b6dc61a8dd3c arch/x86/kernel/setup.c    Andy Lutomirski  2017-05-08  1161  	/*
945fd17ab6bab8 arch/x86/kernel/setup.c    Thomas Gleixner  2018-02-28  1162  	 * Sync back kernel address range.
945fd17ab6bab8 arch/x86/kernel/setup.c    Thomas Gleixner  2018-02-28  1163  	 *
945fd17ab6bab8 arch/x86/kernel/setup.c    Thomas Gleixner  2018-02-28  1164  	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
945fd17ab6bab8 arch/x86/kernel/setup.c    Thomas Gleixner  2018-02-28  1165  	 * this call?
d2b6dc61a8dd3c arch/x86/kernel/setup.c    Andy Lutomirski  2017-05-08  1166  	 */
945fd17ab6bab8 arch/x86/kernel/setup.c    Thomas Gleixner  2018-02-28  1167  	sync_initial_page_table();
d2b6dc61a8dd3c arch/x86/kernel/setup.c    Andy Lutomirski  2017-05-08  1168  
3162534069597e arch/x86/kernel/setup.c    Joseph Cihula    2009-06-30  1169  	tboot_probe();
3162534069597e arch/x86/kernel/setup.c    Joseph Cihula    2009-06-30  1170  
76934ed4b33b65 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-25  1171  	map_vsyscall();
76934ed4b33b65 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-25  1172  
1a3f239ddf9208 arch/i386/kernel/setup.c   Rusty Russell    2006-09-26 @1173  	generic_apic_probe();
^1da177e4c3f41 arch/i386/kernel/setup.c   Linus Torvalds   2005-04-16  1174  
54ef34009a69f9 arch/x86/kernel/setup_32.c Andi Kleen       2007-10-19  1175  	early_quirks();
d44647b0a6e48d arch/i386/kernel/setup.c   Andy Currid      2006-06-08  1176  
295deae401fc5b arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1177  	/*
295deae401fc5b arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1178  	 * Read APIC and some other early information from ACPI tables.
295deae401fc5b arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1179  	 */
^1da177e4c3f41 arch/i386/kernel/setup.c   Linus Torvalds   2005-04-16  1180  	acpi_boot_init();
efafc8b213e67e arch/x86/kernel/setup.c    Feng Tang        2009-08-14  1181  	sfi_init();
a906fdaacca499 arch/x86/kernel/setup.c    Thomas Gleixner  2011-02-25  1182  	x86_dtb_init();
04606618bb50c4 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-21  1183  
295deae401fc5b arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1184  	/*
295deae401fc5b arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1185  	 * get boot-time SMP configuration:
295deae401fc5b arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-23  1186  	 */
e0da33646826b6 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-08  1187  	get_smp_config();
76934ed4b33b65 arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-25  1188  
1e90a13d0c3dc9 arch/x86/kernel/setup.c    Thomas Gleixner  2016-10-29  1189  	/*
1e90a13d0c3dc9 arch/x86/kernel/setup.c    Thomas Gleixner  2016-10-29  1190  	 * Systems w/o ACPI and mptables might not have it mapped the local
1e90a13d0c3dc9 arch/x86/kernel/setup.c    Thomas Gleixner  2016-10-29  1191  	 * APIC yet, but prefill_possible_map() might need to access it.
1e90a13d0c3dc9 arch/x86/kernel/setup.c    Thomas Gleixner  2016-10-29  1192  	 */
1e90a13d0c3dc9 arch/x86/kernel/setup.c    Thomas Gleixner  2016-10-29  1193  	init_apic_mappings();
1e90a13d0c3dc9 arch/x86/kernel/setup.c    Thomas Gleixner  2016-10-29  1194  
329513a35d1a2b arch/x86/kernel/setup.c    Yinghai Lu       2008-07-02  1195  	prefill_possible_map();
301e619020dd67 arch/x86/kernel/setup.c    Yinghai Lu       2008-08-19  1196  
5f4765f96eebee arch/x86/kernel/setup.c    Yinghai Lu       2008-07-02  1197  	init_cpu_to_node();
5f4765f96eebee arch/x86/kernel/setup.c    Yinghai Lu       2008-07-02  1198  
ca1b88622e9c16 arch/x86/kernel/setup.c    Thomas Gleixner  2015-04-24 @1199  	io_apic_init_mappings();
9d6a4d0823b3b8 arch/x86/kernel/setup.c    Yinghai Lu       2008-08-19  1200  
f3614646005a1b arch/x86/kernel/setup.c    Juergen Gross    2017-11-09  1201  	x86_init.hyper.guest_late_init();
^1da177e4c3f41 arch/i386/kernel/setup.c   Linus Torvalds   2005-04-16  1202  
1506c8dc947251 arch/x86/kernel/setup.c    Ingo Molnar      2017-01-28  1203  	e820__reserve_resources();
cc55f7537db6af arch/x86/kernel/setup.c    Zhimin Gu        2018-09-21  1204  	e820__register_nosave_regions(max_pfn);
^1da177e4c3f41 arch/i386/kernel/setup.c   Linus Torvalds   2005-04-16  1205  
8fee697d990c54 arch/x86/kernel/setup.c    Thomas Gleixner  2009-08-19  1206  	x86_init.resources.reserve_resources();
41c094fd3ca54f arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-16  1207  
2df908baf52ccf arch/x86/kernel/setup.c    Ingo Molnar      2017-01-28  1208  	e820__setup_pci_gap();
41c094fd3ca54f arch/x86/kernel/setup_32.c Yinghai Lu       2008-06-16  1209  

:::::: The code at line 1199 was first introduced by commit
:::::: ca1b88622e9c16df7b1e0a57e9c6c2300321bed4 x86: Remove more unmodified io_apic_ops

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--ckcmygq6i5dsp7zy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ckcmygq6i5dsp7zy--
