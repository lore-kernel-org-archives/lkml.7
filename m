Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0DAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA821726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfHWJXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:23:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:47637 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbfHWJXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:23:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 02:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="203715257"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2019 02:23:22 -0700
Received: from [10.226.38.55] (rtanwar-mobl.gar.corp.intel.com [10.226.38.55])
        by linux.intel.com (Postfix) with ESMTP id 9FBA25806C4;
        Fri, 23 Aug 2019 02:23:18 -0700 (PDT)
Subject: Re: [PATCH] x86/cpu: Add new Airmont variant to Intel family
To:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net>
 <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
 <20190822102955.GS2369@hirez.programming.kicks-ass.net>
 <20190822185347.GA8933@agluck-desk2.amr.corp.intel.com>
 <20190822203544.GA10229@agluck-desk2.amr.corp.intel.com>
 <20190823090348.GG2369@hirez.programming.kicks-ass.net>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <48c5ce50-3f53-bb1f-6bf3-d92cd648a7ed@linux.intel.com>
Date:   Fri, 23 Aug 2019 17:23:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190823090348.GG2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peter,

On 23/8/2019 5:03 PM, Peter Zijlstra wrote:
> On Thu, Aug 22, 2019 at 01:35:44PM -0700, Luck, Tony wrote:
>
>> From: Tony Luck <tony.luck@intel.com>
>>
>> One of the use cases for this processor is as a network
>> processor. So give it an "_NP" tag for now. Could be changed
>> later if it turns out to group with some other tag.
>>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   arch/x86/include/asm/intel-family.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
>> index 5c05b2d389c3..23ed388a3a56 100644
>> --- a/arch/x86/include/asm/intel-family.h
>> +++ b/arch/x86/include/asm/intel-family.h
>> @@ -95,6 +95,7 @@
>>   
>>   #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
>>   #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
>> +#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
>>   
>>   #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
>>   #define INTEL_FAM6_ATOM_GOLDMONT_D	0x5F /* Denverton */
> Since it is 'just another airmont' with bits on, should we not then also
> add it to all ATOM_AIRMONT sites already present in the kernel?
>
> something like the below; except there were a few sites I skipped
> because 'no clue'.
>
> Also, while going over that, it looked like we missed AIRMONT_MID from a
> few sites.
>
> I'm thinking we want to add as many of these sites as possible and
> correct when adding a new define; esp. for older microarchs that are
> already well supported.


[PATCH v2 3/3] that i had sent with this series adds these changes which

are applicable to _NP. Please see below link:

https://lkml.org/lkml/2019/8/16/170

Above patch might have missed few additional points which still apply.

Regards,

Rahul



> ---
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 648260b5f367..56e6875b6882 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4647,6 +4647,7 @@ __init int intel_pmu_init(void)
>   	case INTEL_FAM6_ATOM_SILVERMONT_MID:
>   	case INTEL_FAM6_ATOM_AIRMONT:
>   	case INTEL_FAM6_ATOM_AIRMONT_MID:
> +	case INTEL_FAM6_ATOM_AIRMONT_NP:
>   		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
>   			sizeof(hw_cache_event_ids));
>   		memcpy(hw_cache_extra_regs, slm_hw_cache_extra_regs,
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index 688592b34564..1e999092de22 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -602,6 +602,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
>   	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT, slm_cstates),
>   	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_X, slm_cstates),
>   	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,     slm_cstates),
> +	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT_NP,  slm_cstates),
>   
>   	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_CORE,   snb_cstates),
>   	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_XEON_D, snb_cstates),
> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
> index 9431447541e9..fe2323f114c0 100644
> --- a/arch/x86/events/msr.c
> +++ b/arch/x86/events/msr.c
> @@ -72,6 +72,7 @@ static bool test_intel(int idx, void *data)
>   	case INTEL_FAM6_ATOM_SILVERMONT:
>   	case INTEL_FAM6_ATOM_SILVERMONT_X:
>   	case INTEL_FAM6_ATOM_AIRMONT:
> +	case INTEL_FAM6_ATOM_AIRMONT_NP:
>   
>   	case INTEL_FAM6_ATOM_GOLDMONT:
>   	case INTEL_FAM6_ATOM_GOLDMONT_X:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 5cc2d51cc25e..a3ccee6a16a5 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1053,6 +1053,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
>   	VULNWL_INTEL(ATOM_SILVERMONT_X,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
>   	VULNWL_INTEL(ATOM_SILVERMONT_MID,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
>   	VULNWL_INTEL(ATOM_AIRMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
> +	VULNWL_INTEL(ATOM_AIRMONT_NP,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
>   	VULNWL_INTEL(XEON_PHI_KNL,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
>   	VULNWL_INTEL(XEON_PHI_KNM,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
>   
> diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
> index 067858fe4db8..bde7a0c8fa8b 100644
> --- a/arch/x86/kernel/tsc_msr.c
> +++ b/arch/x86/kernel/tsc_msr.c
> @@ -64,6 +64,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
>   	INTEL_CPU_FAM6(ATOM_SILVERMONT,		freq_desc_byt),
>   	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	freq_desc_tng),
>   	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
> +	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		freq_desc_cht),
>   	INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	freq_desc_ann),
>   	{}
>   };
> diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
> index ee6b0780bea1..52990f68af70 100644
> --- a/arch/x86/platform/atom/punit_atom_debug.c
> +++ b/arch/x86/platform/atom/punit_atom_debug.c
> @@ -125,6 +125,7 @@ static const struct x86_cpu_id intel_punit_cpu_ids[] = {
>   	ICPU(INTEL_FAM6_ATOM_SILVERMONT, punit_device_byt),
>   	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,  punit_device_tng),
>   	ICPU(INTEL_FAM6_ATOM_AIRMONT,	  punit_device_cht),
> +	ICPU(INTEL_FAM6_ATOM_AIRMONT_NP,	  punit_device_cht),
>   	{}
>   };
>   
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index d696f165a50e..4da3aef37836 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -313,6 +313,7 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
>   static const struct x86_cpu_id lpss_cpu_ids[] = {
>   	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail */
>   	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
> +	ICPU(INTEL_FAM6_ATOM_AIRMONT_NP),	/* Braswell, Cherry Trail */
>   	{}
>   };
>   
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cc27d4c59dca..878f5dcce41b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1879,6 +1879,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>   	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
>   	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
>   	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
> +	ICPU(INTEL_FAM6_ATOM_AIRMONT_NP,	airmont_funcs),
>   	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
>   	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
>   	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_funcs),
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index fa5ff77b8fe4..277757386ddc 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1070,6 +1070,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>   	INTEL_CPU_FAM6(ATOM_SILVERMONT,		idle_cpu_byt),
>   	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	idle_cpu_tangier),
>   	INTEL_CPU_FAM6(ATOM_AIRMONT,		idle_cpu_cht),
> +	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		idle_cpu_cht),
>   	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
>   	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
>   	INTEL_CPU_FAM6(HASWELL_CORE,		idle_cpu_hsw),
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 6df481896b5f..3104ada7d046 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -981,6 +981,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>   
>   	INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
>   	INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
> +	INTEL_CPU_FAM6(ATOM_AIRMONT_NP, rapl_defaults_cht),
>   	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID, rapl_defaults_tng),
>   	INTEL_CPU_FAM6(ATOM_AIRMONT_MID, rapl_defaults_ann),
>   	INTEL_CPU_FAM6(ATOM_GOLDMONT, rapl_defaults_core),
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 75fc4fb9901c..3ba4f2a77d3e 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -3228,6 +3228,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
>   		pkg_cstate_limits = slv_pkg_cstate_limits;
>   		break;
>   	case INTEL_FAM6_ATOM_AIRMONT:	/* AMT */
> +	case INTEL_FAM6_ATOM_AIRMONT_NP:	/* AMT */
>   		pkg_cstate_limits = amt_pkg_cstate_limits;
>   		no_MSR_MISC_PWR_MGMT = 1;
>   		break;
