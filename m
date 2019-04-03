Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC5F20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SUf1pVmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCO44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:56:56 -0400
Received: from mail-eopbgr790074.outbound.protection.outlook.com ([40.107.79.74]:34771
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbfDCO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV7EuebL2uHgzi06TJZayDZ1onaaL1Ne805JP0DBPj0=;
 b=SUf1pVmtnSmZVjE69uyto00CxXNa9xDDB4lYOAN6YETNPcMSzye357vGw+oaQKMcpXOEhaxy/SvdpnZm0+/sr7kLut5V8fIYnamNqmBecwK7hqL7XYeYahaRS7ACCHWK2xg4XGxyweOQrv/8CLz0rspfebe+fUNHplwNGMO11tk=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2651.namprd12.prod.outlook.com (20.176.116.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Wed, 3 Apr 2019 14:56:13 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Wed, 3 Apr 2019
 14:56:12 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [tip:perf/urgent 4/5] arch/x86//events/amd/core.c:542:9: error:
 'NMI_HANDLED' undeclared; did you mean 'IRQ_HANDLED'?
Thread-Topic: [tip:perf/urgent 4/5] arch/x86//events/amd/core.c:542:9: error:
 'NMI_HANDLED' undeclared; did you mean 'IRQ_HANDLED'?
Thread-Index: AQHU6ixT9YII0ga9hE2P+AqZDCSFQKYqhmQA
Date:   Wed, 3 Apr 2019 14:56:12 +0000
Message-ID: <1e75ab01-cc2e-3ded-ce05-914c48012330@amd.com>
References: <201904032235.CIh9J97I%lkp@intel.com>
In-Reply-To: <201904032235.CIh9J97I%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0025.prod.exchangelabs.com (2603:10b6:805:1::38)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dd07a83-eb97-458b-5413-08d6b84483a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2651;
x-ms-traffictypediagnostic: DM6PR12MB2651:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR12MB2651E14BCA9AE724573676A0EC570@DM6PR12MB2651.namprd12.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(102836004)(14444005)(6916009)(2906002)(316002)(54906003)(105586002)(106356001)(14454004)(478600001)(305945005)(36756003)(446003)(31696002)(966005)(4326008)(6512007)(71190400001)(86362001)(71200400001)(6306002)(53936002)(5024004)(25786009)(5660300002)(76176011)(486006)(6486002)(7736002)(6246003)(6506007)(386003)(66066001)(186003)(72206003)(6436002)(256004)(31686004)(97736004)(476003)(11346002)(26005)(8936002)(52116002)(81156014)(3846002)(81166006)(68736007)(2616005)(6116002)(99286004)(229853002)(8676002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2651;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R3HsdW/TY0AyTlhro+fZjOpf8pSHVpx7ujQrxMr8eLD2114I5+16YEW2FEhmqbvGgrc8Pr/XNn+ARV42U+nzVll5xH9Mb+JKuSANGU9LkOhxnel5/haqTtj0EJCEq/pFfZKmi6SO+VUmOGyA46+3xdMtJIKOKFKp1sGVkBkV69ry3PNz7rTAvalaF33fULxPk8yvzPpDQUNVz48wh50C/qVg1XGVyz8LM9+BjPExNieYYGQ9eGccDkWcx5emYfjS5Ipi1tEMQA41zY5sJ5rGpmb3stM6CoqD6h/BjnvdWojbFLRtLwhkRQf2gl2IIjtu6nwaD7Ivxdfb1azRxXyLofrxu9GDKkAFLT8cFTmbrN+UKvsjJ0YzHk1vBF3OscoQjMVw1yhSHrv6XB5+NaP0mdd3a4tESYxfwde0nuFBsJk=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <12F7B4C240CDED449B7D25847BE899B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd07a83-eb97-458b-5413-08d6b84483a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 14:56:12.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 9:47 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/=
urgent
> head:   60f52ab61c7dc0a991125903ae06a35d1812698c
> commit: 6d3edaae16c6c7d238360f2841212c2b26774d5e [4/5] x86/perf/amd: Reso=
lve NMI latency issues for active PMCs
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          git checkout 6d3edaae16c6c7d238360f2841212c2b26774d5e
>          # save the attached .config to linux build tree
>          make ARCH=3Di386
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>     arch/x86//events/amd/core.c: In function 'amd_pmu_handle_irq':
>     arch/x86//events/amd/core.c:538:10: error: 'NMI_DONE' undeclared (fir=
st use in this function); did you mean 'EM_NONE'?
>        return NMI_DONE;
>               ^~~~~~~~
>               EM_NONE
>     arch/x86//events/amd/core.c:538:10: note: each undeclared identifier =
is reported only once for each function it appears in
>>> arch/x86//events/amd/core.c:542:9: error: 'NMI_HANDLED' undeclared (fir=
st use in this function); did you mean 'IRQ_HANDLED'?
>       return NMI_HANDLED;
>              ^~~~~~~~~~~
>              IRQ_HANDLED
>>> arch/x86//events/amd/core.c:543:1: warning: control reaches end of non-=
void function [-Wreturn-type]
>      }
>      ^
>=20

Looks like I need to change that include back to asm/nmi.h. I should have
looked closer at linux/nmi.h after the checkpatch message.

I'll send a patch to address it.

Thanks,
Tom

> vim +542 arch/x86//events/amd/core.c
>=20
>     493=09
>     494	/*
>     495	 * Because of NMI latency, if multiple PMC counters are active or=
 other sources
>     496	 * of NMIs are received, the perf NMI handler can handle one or m=
ore overflowed
>     497	 * PMC counters outside of the NMI associated with the PMC overfl=
ow. If the NMI
>     498	 * doesn't arrive at the LAPIC in time to become a pending NMI, t=
hen the kernel
>     499	 * back-to-back NMI support won't be active. This PMC handler nee=
ds to take into
>     500	 * account that this can occur, otherwise this could result in un=
known NMI
>     501	 * messages being issued. Examples of this is PMC overflow while =
in the NMI
>     502	 * handler when multiple PMCs are active or PMC overflow while ha=
ndling some
>     503	 * other source of an NMI.
>     504	 *
>     505	 * Attempt to mitigate this by using the number of active PMCs to=
 determine
>     506	 * whether to return NMI_HANDLED if the perf NMI handler did not =
handle/reset
>     507	 * any PMCs. The per-CPU perf_nmi_counter variable is set to a mi=
nimum of the
>     508	 * number of active PMCs or 2. The value of 2 is used in case an =
NMI does not
>     509	 * arrive at the LAPIC in time to be collapsed into an already pe=
nding NMI.
>     510	 */
>     511	static int amd_pmu_handle_irq(struct pt_regs *regs)
>     512	{
>     513		struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>     514		int active, handled;
>     515=09
>     516		/*
>     517		 * Obtain the active count before calling x86_pmu_handle_irq() s=
ince
>     518		 * it is possible that x86_pmu_handle_irq() may make a counter
>     519		 * inactive (through x86_pmu_stop).
>     520		 */
>     521		active =3D __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
>     522=09
>     523		/* Process any counter overflows */
>     524		handled =3D x86_pmu_handle_irq(regs);
>     525=09
>     526		/*
>     527		 * If a counter was handled, record the number of possible remai=
ning
>     528		 * NMIs that can occur.
>     529		 */
>     530		if (handled) {
>     531			this_cpu_write(perf_nmi_counter,
>     532				       min_t(unsigned int, 2, active));
>     533=09
>     534			return handled;
>     535		}
>     536=09
>     537		if (!this_cpu_read(perf_nmi_counter))
>   > 538			return NMI_DONE;
>     539=09
>     540		this_cpu_dec(perf_nmi_counter);
>     541=09
>   > 542		return NMI_HANDLED;
>   > 543	}
>     544=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
>=20
