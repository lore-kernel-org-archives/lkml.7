Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCF520851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="I/0xEMds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbfCAA5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:57:38 -0500
Received: from mail-eopbgr800129.outbound.protection.outlook.com ([40.107.80.129]:4288
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfCAA5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QkIYh4MG5TEUIY6OHSOYT9nGJCneQbHV64p9eAli+0=;
 b=I/0xEMdshXgawGhTkEPdk05xbwXsCTMFizCPBcYYGVOmELJkCAQX/QqwlCxhC0fP+7Ja3/lmbF6Lf3BPlITOS/FMEOhkLHVhT0L6ZKE8IowGbh4K8qZIjV/KgFwHc9SP6REOVl4b0PRiNMO9ZzHp+f2O19V0LN/Qk0SwOam64/I=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1373.namprd22.prod.outlook.com (10.172.60.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 00:56:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Fri, 1 Mar 2019
 00:56:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes for 5.0
Thread-Topic: [GIT PULL] MIPS fixes for 5.0
Thread-Index: AQHUz8moXMFrZPPDYE2hzuXRJsOI4Q==
Date:   Fri, 1 Mar 2019 00:56:52 +0000
Message-ID: <20190301005650.nzsntehn3hpbgcey@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def169e0-db9b-464c-9601-08d69de0cb1d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1373;
x-ms-traffictypediagnostic: MWHPR2201MB1373:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1373;23:aoFy5kbmUGaqK2XQA4WImyRn0Ak5zwaP/WtQ6/H?=
 =?us-ascii?Q?4ifofPlJcbvLv92no7DnCyyIW1h18u3jwG671YagocCqMClHeD1Qql6RFflE?=
 =?us-ascii?Q?ZZ4EnHn4sKzjZFdzNwK1BtyOBL1MOWQ/q42Hf+IpNXLwAQYCRGno1Qf3j84O?=
 =?us-ascii?Q?x0R/7l6o/U3vIf528rvykxvr+QX30N/xB8kibDZwlIVqqoGMV2pyxtot9Mqp?=
 =?us-ascii?Q?TWRR3OgnMYXySWX/gdJknZTMG5M1qjeRzs2LXHYdP/XrrPiM51EkzlYdUe26?=
 =?us-ascii?Q?PymUC3TiX4tICVSoJY2dy5m3tWgzgjk1ObnGBdLOCGqD3ByqDOvFuPwbinSa?=
 =?us-ascii?Q?SU9jjBxhRi/no5NLRYKi4dArivPrzWx6MdVbwwkJVDc0Kfs3pmRqEIddA518?=
 =?us-ascii?Q?T2c2oDuwRa/T5M6w/M3rTI1RxdE7eAanLFTlQMeh5Yjdsde9JTVTLX3hWYkv?=
 =?us-ascii?Q?FZYHlf/Z/acIo2DturXq2JeuPsks0znijeFYVKHm4Gh+g4PbIVc9G300nJIH?=
 =?us-ascii?Q?U4PIH6JSkBcnu2cCzGF1AEzGf90TJdqnghb6h7PLzJaPtyBaQqGXWDi+am+6?=
 =?us-ascii?Q?wIisDeS02mO6EPc0YU4UG9Ue4U6fSpYUfFFKybQQc7xOGeyoHJQ4jYk88fYK?=
 =?us-ascii?Q?oWHoxdv9ItPzqpNfdX1E5W3xu9KTT0uFIxg1xTfrxc5hP59k3IO6HcVS+m6C?=
 =?us-ascii?Q?6lkEIhoN5kgfocoJQaDBvabUnK/zb6wHQmyR2ziCU3bNazaI5lfO0YyJcIMc?=
 =?us-ascii?Q?kNJWiQXWyzm0lzFUYe+6hllfwTkQ4F1Z/VdPcTzKys2T/zrcsrBxdy8b/e7j?=
 =?us-ascii?Q?spPfLAdpSm6MWMlxDuRS8VIge5pWK4kBnWk2r05ZMDvAxYg5oYMVXwYWivID?=
 =?us-ascii?Q?TA+KXQdr1jxylJrwxiTN/mhjCr0wjwySyIQW/9nxNauKsNXN2cXyblBU+lhH?=
 =?us-ascii?Q?dCMv9TVLFhgIwSpe4jD4FgRkAQwS4m8MpUO5gW/LAPCMFAI1PEQJ9SQHmHf7?=
 =?us-ascii?Q?vaqqU8KBDOzR2U8zTVmMmcGxxNimHO6EhS0Rnm4N6W9TG2iQelsaG54d4YKV?=
 =?us-ascii?Q?pjhVb0/98Y2mOqpfrCw4XdXrl6cgQ1AmzXR1uPhYf34ZCrAjY0ZNoSfO3886?=
 =?us-ascii?Q?fkUs8jvkUzwLZqvRx1B++FgBBUuAJUs978dNKSERnhnuBR0gMJXyTSg=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1373D9E4430805AF4F26E705C1760@MWHPR2201MB1373.namprd22.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(376002)(366004)(396003)(39840400004)(189003)(199004)(1076003)(58126008)(6512007)(9686003)(53936002)(316002)(97736004)(6486002)(256004)(105586002)(106356001)(6436002)(4326008)(68736007)(7736002)(305945005)(14454004)(8936002)(25786009)(6116002)(33716001)(8676002)(6916009)(52116002)(42882007)(46003)(486006)(6506007)(386003)(186003)(99286004)(476003)(44832011)(102836004)(54906003)(99936001)(478600001)(71190400001)(71200400001)(5660300002)(2906002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1373;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EQTPHRTtTN3r4FDh4fdqiv6TU0Q3YtQtTb/tJTNxOfwQXWTTyPkIkRUivWnvqiBUGWX72y+CkRheeh4sCaoPSB9KBC7wgVmUrUvBbaOpGcyy7ulVLf7IJOWOi9p1FgxUlivbXAP8Dgb4txlIQ1pa3itlHSLOLe1dcm6HdPj62gUjusdlppqQ3Gcl92SUEBQi0JN6o6YINa+DRRw2cNjceW2o11liFDptkwOctbljjw2Yyy9USiokTz+4a1UFhZdFf2o0bpN3zaQxkI7uz8j26mSwNmb+6OENPMH3uH6th2UzGonzIWyq2HAtC1jxm59AtkDvmmQAOSIJrg6/j8DDhxUyjGFa3u53jEqVznXOkY4OQFcccWcRdyeggZo2PEyBdhKTYeeID+yA7v3k6dLa0yHvqGfEKpLOmJl3U1fh7wk=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ga3cozmag6mqvqrc"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def169e0-db9b-464c-9601-08d69de0cb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 00:56:52.4572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ga3cozmag6mqvqrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

(Resending with fixed subject & PGP sig. /me makes more coffee...)

Here are a few late fixes it'd be great to squeeze into v5.0. They're
all pretty straightforward. Please pull.

Thanks,
    Paul

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.0_4

for you to fetch changes up to e0bf304e4a00d66d90904a6c5b93141f177cf6d2:

  MIPS: fix memory setup for platforms with PHYS_OFFSET != 0 (2019-02-27 18:49:29 -0800)

----------------------------------------------------------------
A few more MIPS fixes:

- Fix 16b cmpxchg() operations which could erroneously fail if bits 15:8
  of the old value are non-zero. In practice I'm not aware of any actual
  users of 16b cmpxchg() on MIPS, but this fixes the support for it was
  was introduced in v4.13.

- Provide a struct device to dma_alloc_coherent for Lantiq XWAY systems
  with a "Voice MIPS Macro Core" (VMMC) device.

- Provide DMA masks for BCM63xx ethernet devices, fixing a regression
  introduced in v4.19.

- Fix memblock reservation for the kernel when the system has a non-zero
  PHYS_OFFSET, correcting the memblock conversion performed in v4.20.

----------------------------------------------------------------
Christoph Hellwig (1):
      MIPS: lantiq: pass struct device to DMA API functions

Jonas Gorski (1):
      MIPS: BCM63XX: provide DMA masks for ethernet devices

Michael Clark (1):
      MIPS: fix truncation in __cmpxchg_small for short values

Thomas Bogendoerfer (1):
      MIPS: fix memory setup for platforms with PHYS_OFFSET != 0

 arch/mips/bcm63xx/dev-enet.c | 8 ++++++++
 arch/mips/kernel/cmpxchg.c   | 3 +--
 arch/mips/kernel/setup.c     | 3 ++-
 arch/mips/lantiq/xway/vmmc.c | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)

--ga3cozmag6mqvqrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXHiDUgAKCRA+p5+stXUA
3c3DAQDFDN7Et2m1/AbHAMlRYsno2EBA4W8lZO0U4kcjQ7rrQgD8DxGlOL9m3wk7
gh56yR2a1IzsxB0DVki7d/NzKKJcrwU=
=ttpE
-----END PGP SIGNATURE-----

--ga3cozmag6mqvqrc--
