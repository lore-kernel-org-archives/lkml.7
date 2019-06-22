Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D78C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486F2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFVILV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:11:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:28972 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfFVILU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:11:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 01:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,403,1557212400"; 
   d="gz'50?scan'50,208,50";a="182264348"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2019 01:11:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1heb7E-00076V-3W; Sat, 22 Jun 2019 16:11:16 +0800
Date:   Sat, 22 Jun 2019 16:10:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [tip:perf/core 24/34] arch/x86/events/intel/core.c:4990:7: error:
 'INTEL_FAM6_ICELAKE_XEON_D' undeclared
Message-ID: <201906221626.SuUq69PZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   a3664a74a0aa0b11d8d4ade04984965b77d14d44
commit: faaeff98666c24376cebd0b106504d05a36881d1 [24/34] perf/x86/intel: Add more Icelake CPUIDs
config: x86_64-randconfig-n028-201924 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout faaeff98666c24376cebd0b106504d05a36881d1
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/events/intel/core.c: In function 'intel_pmu_init':
   arch/x86/events/intel/core.c:4989:7: error: 'INTEL_FAM6_ICELAKE_X' undeclared (first use in this function)
     case INTEL_FAM6_ICELAKE_X:
          ^~~~~~~~~~~~~~~~~~~~
   arch/x86/events/intel/core.c:4989:7: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/events/intel/core.c:4990:7: error: 'INTEL_FAM6_ICELAKE_XEON_D' undeclared (first use in this function)
     case INTEL_FAM6_ICELAKE_XEON_D:
          ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/events/intel/core.c:4993:7: error: 'INTEL_FAM6_ICELAKE_DESKTOP' undeclared (first use in this function)
     case INTEL_FAM6_ICELAKE_DESKTOP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/INTEL_FAM6_ICELAKE_XEON_D +4990 arch/x86/events/intel/core.c

  4474	
  4475	__init int intel_pmu_init(void)
  4476	{
  4477		struct attribute **extra_skl_attr = &empty_attrs;
  4478		struct attribute **extra_attr = &empty_attrs;
  4479		struct attribute **td_attr    = &empty_attrs;
  4480		struct attribute **mem_attr   = &empty_attrs;
  4481		struct attribute **tsx_attr   = &empty_attrs;
  4482		union cpuid10_edx edx;
  4483		union cpuid10_eax eax;
  4484		union cpuid10_ebx ebx;
  4485		struct event_constraint *c;
  4486		unsigned int unused;
  4487		struct extra_reg *er;
  4488		bool pmem = false;
  4489		int version, i;
  4490		char *name;
  4491	
  4492		if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
  4493			switch (boot_cpu_data.x86) {
  4494			case 0x6:
  4495				return p6_pmu_init();
  4496			case 0xb:
  4497				return knc_pmu_init();
  4498			case 0xf:
  4499				return p4_pmu_init();
  4500			}
  4501			return -ENODEV;
  4502		}
  4503	
  4504		/*
  4505		 * Check whether the Architectural PerfMon supports
  4506		 * Branch Misses Retired hw_event or not.
  4507		 */
  4508		cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
  4509		if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
  4510			return -ENODEV;
  4511	
  4512		version = eax.split.version_id;
  4513		if (version < 2)
  4514			x86_pmu = core_pmu;
  4515		else
  4516			x86_pmu = intel_pmu;
  4517	
  4518		x86_pmu.version			= version;
  4519		x86_pmu.num_counters		= eax.split.num_counters;
  4520		x86_pmu.cntval_bits		= eax.split.bit_width;
  4521		x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
  4522	
  4523		x86_pmu.events_maskl		= ebx.full;
  4524		x86_pmu.events_mask_len		= eax.split.mask_length;
  4525	
  4526		x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
  4527	
  4528		/*
  4529		 * Quirk: v2 perfmon does not report fixed-purpose events, so
  4530		 * assume at least 3 events, when not running in a hypervisor:
  4531		 */
  4532		if (version > 1) {
  4533			int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
  4534	
  4535			x86_pmu.num_counters_fixed =
  4536				max((int)edx.split.num_counters_fixed, assume);
  4537		}
  4538	
  4539		if (version >= 4)
  4540			x86_pmu.counter_freezing = !disable_counter_freezing;
  4541	
  4542		if (boot_cpu_has(X86_FEATURE_PDCM)) {
  4543			u64 capabilities;
  4544	
  4545			rdmsrl(MSR_IA32_PERF_CAPABILITIES, capabilities);
  4546			x86_pmu.intel_cap.capabilities = capabilities;
  4547		}
  4548	
  4549		intel_ds_init();
  4550	
  4551		x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
  4552	
  4553		/*
  4554		 * Install the hw-cache-events table:
  4555		 */
  4556		switch (boot_cpu_data.x86_model) {
  4557		case INTEL_FAM6_CORE_YONAH:
  4558			pr_cont("Core events, ");
  4559			name = "core";
  4560			break;
  4561	
  4562		case INTEL_FAM6_CORE2_MEROM:
  4563			x86_add_quirk(intel_clovertown_quirk);
  4564			/* fall through */
  4565	
  4566		case INTEL_FAM6_CORE2_MEROM_L:
  4567		case INTEL_FAM6_CORE2_PENRYN:
  4568		case INTEL_FAM6_CORE2_DUNNINGTON:
  4569			memcpy(hw_cache_event_ids, core2_hw_cache_event_ids,
  4570			       sizeof(hw_cache_event_ids));
  4571	
  4572			intel_pmu_lbr_init_core();
  4573	
  4574			x86_pmu.event_constraints = intel_core2_event_constraints;
  4575			x86_pmu.pebs_constraints = intel_core2_pebs_event_constraints;
  4576			pr_cont("Core2 events, ");
  4577			name = "core2";
  4578			break;
  4579	
  4580		case INTEL_FAM6_NEHALEM:
  4581		case INTEL_FAM6_NEHALEM_EP:
  4582		case INTEL_FAM6_NEHALEM_EX:
  4583			memcpy(hw_cache_event_ids, nehalem_hw_cache_event_ids,
  4584			       sizeof(hw_cache_event_ids));
  4585			memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
  4586			       sizeof(hw_cache_extra_regs));
  4587	
  4588			intel_pmu_lbr_init_nhm();
  4589	
  4590			x86_pmu.event_constraints = intel_nehalem_event_constraints;
  4591			x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
  4592			x86_pmu.enable_all = intel_pmu_nhm_enable_all;
  4593			x86_pmu.extra_regs = intel_nehalem_extra_regs;
  4594	
  4595			mem_attr = nhm_mem_events_attrs;
  4596	
  4597			/* UOPS_ISSUED.STALLED_CYCLES */
  4598			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4599				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4600			/* UOPS_EXECUTED.CORE_ACTIVE_CYCLES,c=1,i=1 */
  4601			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
  4602				X86_CONFIG(.event=0xb1, .umask=0x3f, .inv=1, .cmask=1);
  4603	
  4604			intel_pmu_pebs_data_source_nhm();
  4605			x86_add_quirk(intel_nehalem_quirk);
  4606			x86_pmu.pebs_no_tlb = 1;
  4607			extra_attr = nhm_format_attr;
  4608	
  4609			pr_cont("Nehalem events, ");
  4610			name = "nehalem";
  4611			break;
  4612	
  4613		case INTEL_FAM6_ATOM_BONNELL:
  4614		case INTEL_FAM6_ATOM_BONNELL_MID:
  4615		case INTEL_FAM6_ATOM_SALTWELL:
  4616		case INTEL_FAM6_ATOM_SALTWELL_MID:
  4617		case INTEL_FAM6_ATOM_SALTWELL_TABLET:
  4618			memcpy(hw_cache_event_ids, atom_hw_cache_event_ids,
  4619			       sizeof(hw_cache_event_ids));
  4620	
  4621			intel_pmu_lbr_init_atom();
  4622	
  4623			x86_pmu.event_constraints = intel_gen_event_constraints;
  4624			x86_pmu.pebs_constraints = intel_atom_pebs_event_constraints;
  4625			x86_pmu.pebs_aliases = intel_pebs_aliases_core2;
  4626			pr_cont("Atom events, ");
  4627			name = "bonnell";
  4628			break;
  4629	
  4630		case INTEL_FAM6_ATOM_SILVERMONT:
  4631		case INTEL_FAM6_ATOM_SILVERMONT_X:
  4632		case INTEL_FAM6_ATOM_SILVERMONT_MID:
  4633		case INTEL_FAM6_ATOM_AIRMONT:
  4634		case INTEL_FAM6_ATOM_AIRMONT_MID:
  4635			memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
  4636				sizeof(hw_cache_event_ids));
  4637			memcpy(hw_cache_extra_regs, slm_hw_cache_extra_regs,
  4638			       sizeof(hw_cache_extra_regs));
  4639	
  4640			intel_pmu_lbr_init_slm();
  4641	
  4642			x86_pmu.event_constraints = intel_slm_event_constraints;
  4643			x86_pmu.pebs_constraints = intel_slm_pebs_event_constraints;
  4644			x86_pmu.extra_regs = intel_slm_extra_regs;
  4645			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4646			td_attr = slm_events_attrs;
  4647			extra_attr = slm_format_attr;
  4648			pr_cont("Silvermont events, ");
  4649			name = "silvermont";
  4650			break;
  4651	
  4652		case INTEL_FAM6_ATOM_GOLDMONT:
  4653		case INTEL_FAM6_ATOM_GOLDMONT_X:
  4654			x86_add_quirk(intel_counter_freezing_quirk);
  4655			memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
  4656			       sizeof(hw_cache_event_ids));
  4657			memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
  4658			       sizeof(hw_cache_extra_regs));
  4659	
  4660			intel_pmu_lbr_init_skl();
  4661	
  4662			x86_pmu.event_constraints = intel_slm_event_constraints;
  4663			x86_pmu.pebs_constraints = intel_glm_pebs_event_constraints;
  4664			x86_pmu.extra_regs = intel_glm_extra_regs;
  4665			/*
  4666			 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
  4667			 * for precise cycles.
  4668			 * :pp is identical to :ppp
  4669			 */
  4670			x86_pmu.pebs_aliases = NULL;
  4671			x86_pmu.pebs_prec_dist = true;
  4672			x86_pmu.lbr_pt_coexist = true;
  4673			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4674			td_attr = glm_events_attrs;
  4675			extra_attr = slm_format_attr;
  4676			pr_cont("Goldmont events, ");
  4677			name = "goldmont";
  4678			break;
  4679	
  4680		case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
  4681			x86_add_quirk(intel_counter_freezing_quirk);
  4682			memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
  4683			       sizeof(hw_cache_event_ids));
  4684			memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
  4685			       sizeof(hw_cache_extra_regs));
  4686	
  4687			intel_pmu_lbr_init_skl();
  4688	
  4689			x86_pmu.event_constraints = intel_slm_event_constraints;
  4690			x86_pmu.extra_regs = intel_glm_extra_regs;
  4691			/*
  4692			 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
  4693			 * for precise cycles.
  4694			 */
  4695			x86_pmu.pebs_aliases = NULL;
  4696			x86_pmu.pebs_prec_dist = true;
  4697			x86_pmu.lbr_pt_coexist = true;
  4698			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4699			x86_pmu.flags |= PMU_FL_PEBS_ALL;
  4700			x86_pmu.get_event_constraints = glp_get_event_constraints;
  4701			td_attr = glm_events_attrs;
  4702			/* Goldmont Plus has 4-wide pipeline */
  4703			event_attr_td_total_slots_scale_glm.event_str = "4";
  4704			extra_attr = slm_format_attr;
  4705			pr_cont("Goldmont plus events, ");
  4706			name = "goldmont_plus";
  4707			break;
  4708	
  4709		case INTEL_FAM6_ATOM_TREMONT_X:
  4710			x86_pmu.late_ack = true;
  4711			memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
  4712			       sizeof(hw_cache_event_ids));
  4713			memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
  4714			       sizeof(hw_cache_extra_regs));
  4715			hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
  4716	
  4717			intel_pmu_lbr_init_skl();
  4718	
  4719			x86_pmu.event_constraints = intel_slm_event_constraints;
  4720			x86_pmu.extra_regs = intel_tnt_extra_regs;
  4721			/*
  4722			 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
  4723			 * for precise cycles.
  4724			 */
  4725			x86_pmu.pebs_aliases = NULL;
  4726			x86_pmu.pebs_prec_dist = true;
  4727			x86_pmu.lbr_pt_coexist = true;
  4728			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4729			x86_pmu.get_event_constraints = tnt_get_event_constraints;
  4730			extra_attr = slm_format_attr;
  4731			pr_cont("Tremont events, ");
  4732			name = "Tremont";
  4733			break;
  4734	
  4735		case INTEL_FAM6_WESTMERE:
  4736		case INTEL_FAM6_WESTMERE_EP:
  4737		case INTEL_FAM6_WESTMERE_EX:
  4738			memcpy(hw_cache_event_ids, westmere_hw_cache_event_ids,
  4739			       sizeof(hw_cache_event_ids));
  4740			memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
  4741			       sizeof(hw_cache_extra_regs));
  4742	
  4743			intel_pmu_lbr_init_nhm();
  4744	
  4745			x86_pmu.event_constraints = intel_westmere_event_constraints;
  4746			x86_pmu.enable_all = intel_pmu_nhm_enable_all;
  4747			x86_pmu.pebs_constraints = intel_westmere_pebs_event_constraints;
  4748			x86_pmu.extra_regs = intel_westmere_extra_regs;
  4749			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4750	
  4751			mem_attr = nhm_mem_events_attrs;
  4752	
  4753			/* UOPS_ISSUED.STALLED_CYCLES */
  4754			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4755				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4756			/* UOPS_EXECUTED.CORE_ACTIVE_CYCLES,c=1,i=1 */
  4757			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
  4758				X86_CONFIG(.event=0xb1, .umask=0x3f, .inv=1, .cmask=1);
  4759	
  4760			intel_pmu_pebs_data_source_nhm();
  4761			extra_attr = nhm_format_attr;
  4762			pr_cont("Westmere events, ");
  4763			name = "westmere";
  4764			break;
  4765	
  4766		case INTEL_FAM6_SANDYBRIDGE:
  4767		case INTEL_FAM6_SANDYBRIDGE_X:
  4768			x86_add_quirk(intel_sandybridge_quirk);
  4769			x86_add_quirk(intel_ht_bug);
  4770			memcpy(hw_cache_event_ids, snb_hw_cache_event_ids,
  4771			       sizeof(hw_cache_event_ids));
  4772			memcpy(hw_cache_extra_regs, snb_hw_cache_extra_regs,
  4773			       sizeof(hw_cache_extra_regs));
  4774	
  4775			intel_pmu_lbr_init_snb();
  4776	
  4777			x86_pmu.event_constraints = intel_snb_event_constraints;
  4778			x86_pmu.pebs_constraints = intel_snb_pebs_event_constraints;
  4779			x86_pmu.pebs_aliases = intel_pebs_aliases_snb;
  4780			if (boot_cpu_data.x86_model == INTEL_FAM6_SANDYBRIDGE_X)
  4781				x86_pmu.extra_regs = intel_snbep_extra_regs;
  4782			else
  4783				x86_pmu.extra_regs = intel_snb_extra_regs;
  4784	
  4785	
  4786			/* all extra regs are per-cpu when HT is on */
  4787			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4788			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4789	
  4790			td_attr  = snb_events_attrs;
  4791			mem_attr = snb_mem_events_attrs;
  4792	
  4793			/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
  4794			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4795				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4796			/* UOPS_DISPATCHED.THREAD,c=1,i=1 to count stall cycles*/
  4797			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
  4798				X86_CONFIG(.event=0xb1, .umask=0x01, .inv=1, .cmask=1);
  4799	
  4800			extra_attr = nhm_format_attr;
  4801	
  4802			pr_cont("SandyBridge events, ");
  4803			name = "sandybridge";
  4804			break;
  4805	
  4806		case INTEL_FAM6_IVYBRIDGE:
  4807		case INTEL_FAM6_IVYBRIDGE_X:
  4808			x86_add_quirk(intel_ht_bug);
  4809			memcpy(hw_cache_event_ids, snb_hw_cache_event_ids,
  4810			       sizeof(hw_cache_event_ids));
  4811			/* dTLB-load-misses on IVB is different than SNB */
  4812			hw_cache_event_ids[C(DTLB)][C(OP_READ)][C(RESULT_MISS)] = 0x8108; /* DTLB_LOAD_MISSES.DEMAND_LD_MISS_CAUSES_A_WALK */
  4813	
  4814			memcpy(hw_cache_extra_regs, snb_hw_cache_extra_regs,
  4815			       sizeof(hw_cache_extra_regs));
  4816	
  4817			intel_pmu_lbr_init_snb();
  4818	
  4819			x86_pmu.event_constraints = intel_ivb_event_constraints;
  4820			x86_pmu.pebs_constraints = intel_ivb_pebs_event_constraints;
  4821			x86_pmu.pebs_aliases = intel_pebs_aliases_ivb;
  4822			x86_pmu.pebs_prec_dist = true;
  4823			if (boot_cpu_data.x86_model == INTEL_FAM6_IVYBRIDGE_X)
  4824				x86_pmu.extra_regs = intel_snbep_extra_regs;
  4825			else
  4826				x86_pmu.extra_regs = intel_snb_extra_regs;
  4827			/* all extra regs are per-cpu when HT is on */
  4828			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4829			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4830	
  4831			td_attr  = snb_events_attrs;
  4832			mem_attr = snb_mem_events_attrs;
  4833	
  4834			/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
  4835			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4836				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4837	
  4838			extra_attr = nhm_format_attr;
  4839	
  4840			pr_cont("IvyBridge events, ");
  4841			name = "ivybridge";
  4842			break;
  4843	
  4844	
  4845		case INTEL_FAM6_HASWELL_CORE:
  4846		case INTEL_FAM6_HASWELL_X:
  4847		case INTEL_FAM6_HASWELL_ULT:
  4848		case INTEL_FAM6_HASWELL_GT3E:
  4849			x86_add_quirk(intel_ht_bug);
  4850			x86_add_quirk(intel_pebs_isolation_quirk);
  4851			x86_pmu.late_ack = true;
  4852			memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4853			memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4854	
  4855			intel_pmu_lbr_init_hsw();
  4856	
  4857			x86_pmu.event_constraints = intel_hsw_event_constraints;
  4858			x86_pmu.pebs_constraints = intel_hsw_pebs_event_constraints;
  4859			x86_pmu.extra_regs = intel_snbep_extra_regs;
  4860			x86_pmu.pebs_aliases = intel_pebs_aliases_ivb;
  4861			x86_pmu.pebs_prec_dist = true;
  4862			/* all extra regs are per-cpu when HT is on */
  4863			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4864			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4865	
  4866			x86_pmu.hw_config = hsw_hw_config;
  4867			x86_pmu.get_event_constraints = hsw_get_event_constraints;
  4868			x86_pmu.lbr_double_abort = true;
  4869			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  4870				hsw_format_attr : nhm_format_attr;
  4871			td_attr  = hsw_events_attrs;
  4872			mem_attr = hsw_mem_events_attrs;
  4873			tsx_attr = hsw_tsx_events_attrs;
  4874			pr_cont("Haswell events, ");
  4875			name = "haswell";
  4876			break;
  4877	
  4878		case INTEL_FAM6_BROADWELL_CORE:
  4879		case INTEL_FAM6_BROADWELL_XEON_D:
  4880		case INTEL_FAM6_BROADWELL_GT3E:
  4881		case INTEL_FAM6_BROADWELL_X:
  4882			x86_add_quirk(intel_pebs_isolation_quirk);
  4883			x86_pmu.late_ack = true;
  4884			memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4885			memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4886	
  4887			/* L3_MISS_LOCAL_DRAM is BIT(26) in Broadwell */
  4888			hw_cache_extra_regs[C(LL)][C(OP_READ)][C(RESULT_MISS)] = HSW_DEMAND_READ |
  4889										 BDW_L3_MISS|HSW_SNOOP_DRAM;
  4890			hw_cache_extra_regs[C(LL)][C(OP_WRITE)][C(RESULT_MISS)] = HSW_DEMAND_WRITE|BDW_L3_MISS|
  4891										  HSW_SNOOP_DRAM;
  4892			hw_cache_extra_regs[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = HSW_DEMAND_READ|
  4893										     BDW_L3_MISS_LOCAL|HSW_SNOOP_DRAM;
  4894			hw_cache_extra_regs[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = HSW_DEMAND_WRITE|
  4895										      BDW_L3_MISS_LOCAL|HSW_SNOOP_DRAM;
  4896	
  4897			intel_pmu_lbr_init_hsw();
  4898	
  4899			x86_pmu.event_constraints = intel_bdw_event_constraints;
  4900			x86_pmu.pebs_constraints = intel_bdw_pebs_event_constraints;
  4901			x86_pmu.extra_regs = intel_snbep_extra_regs;
  4902			x86_pmu.pebs_aliases = intel_pebs_aliases_ivb;
  4903			x86_pmu.pebs_prec_dist = true;
  4904			/* all extra regs are per-cpu when HT is on */
  4905			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4906			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4907	
  4908			x86_pmu.hw_config = hsw_hw_config;
  4909			x86_pmu.get_event_constraints = hsw_get_event_constraints;
  4910			x86_pmu.limit_period = bdw_limit_period;
  4911			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  4912				hsw_format_attr : nhm_format_attr;
  4913			td_attr  = hsw_events_attrs;
  4914			mem_attr = hsw_mem_events_attrs;
  4915			tsx_attr = hsw_tsx_events_attrs;
  4916			pr_cont("Broadwell events, ");
  4917			name = "broadwell";
  4918			break;
  4919	
  4920		case INTEL_FAM6_XEON_PHI_KNL:
  4921		case INTEL_FAM6_XEON_PHI_KNM:
  4922			memcpy(hw_cache_event_ids,
  4923			       slm_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4924			memcpy(hw_cache_extra_regs,
  4925			       knl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4926			intel_pmu_lbr_init_knl();
  4927	
  4928			x86_pmu.event_constraints = intel_slm_event_constraints;
  4929			x86_pmu.pebs_constraints = intel_slm_pebs_event_constraints;
  4930			x86_pmu.extra_regs = intel_knl_extra_regs;
  4931	
  4932			/* all extra regs are per-cpu when HT is on */
  4933			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4934			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4935			extra_attr = slm_format_attr;
  4936			pr_cont("Knights Landing/Mill events, ");
  4937			name = "knights-landing";
  4938			break;
  4939	
  4940		case INTEL_FAM6_SKYLAKE_X:
  4941			pmem = true;
  4942		case INTEL_FAM6_SKYLAKE_MOBILE:
  4943		case INTEL_FAM6_SKYLAKE_DESKTOP:
  4944		case INTEL_FAM6_KABYLAKE_MOBILE:
  4945		case INTEL_FAM6_KABYLAKE_DESKTOP:
  4946			x86_add_quirk(intel_pebs_isolation_quirk);
  4947			x86_pmu.late_ack = true;
  4948			memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4949			memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4950			intel_pmu_lbr_init_skl();
  4951	
  4952			/* INT_MISC.RECOVERY_CYCLES has umask 1 in Skylake */
  4953			event_attr_td_recovery_bubbles.event_str_noht =
  4954				"event=0xd,umask=0x1,cmask=1";
  4955			event_attr_td_recovery_bubbles.event_str_ht =
  4956				"event=0xd,umask=0x1,cmask=1,any=1";
  4957	
  4958			x86_pmu.event_constraints = intel_skl_event_constraints;
  4959			x86_pmu.pebs_constraints = intel_skl_pebs_event_constraints;
  4960			x86_pmu.extra_regs = intel_skl_extra_regs;
  4961			x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
  4962			x86_pmu.pebs_prec_dist = true;
  4963			/* all extra regs are per-cpu when HT is on */
  4964			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4965			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4966	
  4967			x86_pmu.hw_config = hsw_hw_config;
  4968			x86_pmu.get_event_constraints = hsw_get_event_constraints;
  4969			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  4970				hsw_format_attr : nhm_format_attr;
  4971			extra_skl_attr = skl_format_attr;
  4972			td_attr  = hsw_events_attrs;
  4973			mem_attr = hsw_mem_events_attrs;
  4974			tsx_attr = hsw_tsx_events_attrs;
  4975			intel_pmu_pebs_data_source_skl(pmem);
  4976	
  4977			if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
  4978				x86_pmu.flags |= PMU_FL_TFA;
  4979				x86_pmu.get_event_constraints = tfa_get_event_constraints;
  4980				x86_pmu.enable_all = intel_tfa_pmu_enable_all;
  4981				x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
  4982				intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
  4983			}
  4984	
  4985			pr_cont("Skylake events, ");
  4986			name = "skylake";
  4987			break;
  4988	
> 4989		case INTEL_FAM6_ICELAKE_X:
> 4990		case INTEL_FAM6_ICELAKE_XEON_D:
  4991			pmem = true;
  4992		case INTEL_FAM6_ICELAKE_MOBILE:
> 4993		case INTEL_FAM6_ICELAKE_DESKTOP:
  4994			x86_pmu.late_ack = true;
  4995			memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4996			memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4997			hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
  4998			intel_pmu_lbr_init_skl();
  4999	
  5000			x86_pmu.event_constraints = intel_icl_event_constraints;
  5001			x86_pmu.pebs_constraints = intel_icl_pebs_event_constraints;
  5002			x86_pmu.extra_regs = intel_icl_extra_regs;
  5003			x86_pmu.pebs_aliases = NULL;
  5004			x86_pmu.pebs_prec_dist = true;
  5005			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  5006			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  5007	
  5008			x86_pmu.hw_config = hsw_hw_config;
  5009			x86_pmu.get_event_constraints = icl_get_event_constraints;
  5010			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  5011				hsw_format_attr : nhm_format_attr;
  5012			extra_skl_attr = skl_format_attr;
  5013			mem_attr = icl_events_attrs;
  5014			tsx_attr = icl_tsx_events_attrs;
  5015			x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
  5016			x86_pmu.lbr_pt_coexist = true;
  5017			intel_pmu_pebs_data_source_skl(pmem);
  5018			pr_cont("Icelake events, ");
  5019			name = "icelake";
  5020			break;
  5021	
  5022		default:
  5023			switch (x86_pmu.version) {
  5024			case 1:
  5025				x86_pmu.event_constraints = intel_v1_event_constraints;
  5026				pr_cont("generic architected perfmon v1, ");
  5027				name = "generic_arch_v1";
  5028				break;
  5029			default:
  5030				/*
  5031				 * default constraints for v2 and up
  5032				 */
  5033				x86_pmu.event_constraints = intel_gen_event_constraints;
  5034				pr_cont("generic architected perfmon, ");
  5035				name = "generic_arch_v2+";
  5036				break;
  5037			}
  5038		}
  5039	
  5040		snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
  5041	
  5042	
  5043		group_events_td.attrs  = td_attr;
  5044		group_events_mem.attrs = mem_attr;
  5045		group_events_tsx.attrs = tsx_attr;
  5046		group_format_extra.attrs = extra_attr;
  5047		group_format_extra_skl.attrs = extra_skl_attr;
  5048	
  5049		x86_pmu.attr_update = attr_update;
  5050	
  5051		if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
  5052			WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
  5053			     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
  5054			x86_pmu.num_counters = INTEL_PMC_MAX_GENERIC;
  5055		}
  5056		x86_pmu.intel_ctrl = (1ULL << x86_pmu.num_counters) - 1;
  5057	
  5058		if (x86_pmu.num_counters_fixed > INTEL_PMC_MAX_FIXED) {
  5059			WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
  5060			     x86_pmu.num_counters_fixed, INTEL_PMC_MAX_FIXED);
  5061			x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
  5062		}
  5063	
  5064		x86_pmu.intel_ctrl |=
  5065			((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
  5066	
  5067		if (x86_pmu.event_constraints) {
  5068			/*
  5069			 * event on fixed counter2 (REF_CYCLES) only works on this
  5070			 * counter, so do not extend mask to generic counters
  5071			 */
  5072			for_each_event_constraint(c, x86_pmu.event_constraints) {
  5073				if (c->cmask == FIXED_EVENT_FLAGS
  5074				    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
  5075					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
  5076				}
  5077				c->idxmsk64 &=
  5078					~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
  5079				c->weight = hweight64(c->idxmsk64);
  5080			}
  5081		}
  5082	
  5083		/*
  5084		 * Access LBR MSR may cause #GP under certain circumstances.
  5085		 * E.g. KVM doesn't support LBR MSR
  5086		 * Check all LBT MSR here.
  5087		 * Disable LBR access if any LBR MSRs can not be accessed.
  5088		 */
  5089		if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
  5090			x86_pmu.lbr_nr = 0;
  5091		for (i = 0; i < x86_pmu.lbr_nr; i++) {
  5092			if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
  5093			      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
  5094				x86_pmu.lbr_nr = 0;
  5095		}
  5096	
  5097		if (x86_pmu.lbr_nr)
  5098			pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
  5099	
  5100		/*
  5101		 * Access extra MSR may cause #GP under certain circumstances.
  5102		 * E.g. KVM doesn't support offcore event
  5103		 * Check all extra_regs here.
  5104		 */
  5105		if (x86_pmu.extra_regs) {
  5106			for (er = x86_pmu.extra_regs; er->msr; er++) {
  5107				er->extra_msr_access = check_msr(er->msr, 0x11UL);
  5108				/* Disable LBR select mapping */
  5109				if ((er->idx == EXTRA_REG_LBR) && !er->extra_msr_access)
  5110					x86_pmu.lbr_sel_map = NULL;
  5111			}
  5112		}
  5113	
  5114		/* Support full width counters using alternative MSR range */
  5115		if (x86_pmu.intel_cap.full_width_write) {
  5116			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
  5117			x86_pmu.perfctr = MSR_IA32_PMC0;
  5118			pr_cont("full-width counters, ");
  5119		}
  5120	
  5121		/*
  5122		 * For arch perfmon 4 use counter freezing to avoid
  5123		 * several MSR accesses in the PMI.
  5124		 */
  5125		if (x86_pmu.counter_freezing)
  5126			x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
  5127	
  5128		return 0;
  5129	}
  5130	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aPf62/fPVW9M/w9HlX5FwtwBAA==

--NzB8fVQJ5HfG6fxh--
