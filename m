Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE8CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF77206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JhCsoiHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfDCXXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:23:45 -0400
Received: from mail-eopbgr700106.outbound.protection.outlook.com ([40.107.70.106]:37822
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfDCXXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 19:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+Sjez4Ddvk1hEli42OqP5azO2I11L2I0zu8TosAzfg=;
 b=JhCsoiHOYfEpJvu/9n8o0pa7C834hkf/ATqbWqnoonSjkSQgsM+ys385N7okzusTMvXzQcKy8I9uAtYTUvBoDm2kdaJKZ9f9NV+yx7H0Emn1KDLMMiTB6zh2wfgvSSCCbgVIjdf1fZcUSJtOnyoh1K9qgIAajNaupuWMSpUCWyI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1136.namprd22.prod.outlook.com (10.174.171.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Wed, 3 Apr 2019 23:23:40 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%6]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 23:23:40 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] MIPS: generic: Add switchdev, pinctrl and fit to
 ocelot_defconfig
Thread-Topic: [PATCH net-next] MIPS: generic: Add switchdev, pinctrl and fit
 to ocelot_defconfig
Thread-Index: AQHU6jH1855jdykjrkiwYTkluuuwSaYrFB8A
Date:   Wed, 3 Apr 2019 23:23:39 +0000
Message-ID: <20190403232334.7joxmw2a3qrhy2nf@pburton-laptop>
References: <1554305256-32702-1-git-send-email-horatiu.vultur@microchip.com>
In-Reply-To: <1554305256-32702-1-git-send-email-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40ec7b10-3ba4-40fe-7858-08d6b88b676d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1136;
x-ms-traffictypediagnostic: MWHPR2201MB1136:
x-microsoft-antispam-prvs: <MWHPR2201MB11365F12B39218E3AE876585C1570@MWHPR2201MB1136.namprd22.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(39850400004)(396003)(376002)(346002)(199004)(189003)(1076003)(71200400001)(58126008)(256004)(42882007)(71190400001)(2906002)(102836004)(386003)(44832011)(54906003)(25786009)(106356001)(81166006)(11346002)(76176011)(478600001)(6506007)(7736002)(8936002)(6116002)(446003)(6916009)(316002)(33716001)(476003)(305945005)(4326008)(14444005)(186003)(6512007)(105586002)(5660300002)(97736004)(99286004)(68736007)(66066001)(6436002)(6246003)(53936002)(229853002)(6486002)(14454004)(486006)(8676002)(81156014)(9686003)(26005)(52116002)(3846002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1136;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /b4CyPsuCIV/0sX3d0c236h5QV3LWzJSnlrmTz6NjfFNa+QZQ2+0a14gnofDxI7BoMjIbpFMv0Pf23W2yS5ejXyv2fGq13td8Au2G263dKqOJeg0HqJUXyY3VS2P0mKD5pcx/kHxM93sV2IX8Hcr/1v+HB+kQ8FlqP3he1Zd0r2mtODmPSz97JW+B5IN3jNbSaVhU/Vj6u2domYD5gtpO47YeNra5kruGgSLZfhlutrSga0c58/hha7N7vQdflQabq6UGKdd21HQovqNnBXLf4ybMsBIXSxuaeCEAONV9ZNWCy79gQOoO2zbpn/nM7cgw1D5dtn9kL33VjhI9ZyyUqAFUz4iHurWkpeICl/DYIX4iYP0e4Os6EN2UuOkKsLCzxCb071quBsral6K1VjC/+nI7NxiWVWy4u+ZYW5h7iw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1319EAE0211D67469C35922C52AC9897@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ec7b10-3ba4-40fe-7858-08d6b88b676d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 23:23:39.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On Wed, Apr 03, 2019 at 05:27:36PM +0200, Horatiu Vultur wrote:
> diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/co=
nfigs/generic/board-ocelot.config
> index f607888..3215741 100644
> --- a/arch/mips/configs/generic/board-ocelot.config
> +++ b/arch/mips/configs/generic/board-ocelot.config
>%
> +# CONFIG_HID is not set
> +# CONFIG_USB_SUPPORT is not set
> +# CONFIG_VIRTIO_MENU is not set
> +# CONFIG_SCSI is not set

Unfortunately this part won't work so well. If board-ocelot.config
disables these things, then what should happen if another board that's
also included in a generic kernel enables them?

eg. if you run 'make ARCH=3Dmips 32r2el_defconfig' then we merge all of
the following:

  board-boston.config enables USB
  board-sead-3.config enables USB
  board-ocelot.config disables USB

These are mutually exclusive, and it seems that on my system we
currently end up disabling USB due to board-ocelot.config. That will of
course break USB support for Boston or SEAD-3 which are also supported
by the same kernel binary. In practice which one 'wins' will depend on
the order the files are listed by make's wildcard function - so far as
I'm aware that doesn't guarantee any particular order so if it ends up
depending on the order the filesystem lists the files or something like
that then configurations might even differ when used on different
machines.

So to avoid that the best we can do is leave these enabled and the
general rule is that board-*.config files can only enable extra things,
not disable them.

You might be tempted to disable the options in generic_defconfig &
update any board configs that actually need them to enable them, but
that doesn't work too well for things which are 'default y' because
kconfig then warns about the conflict between generic_defconfig & the
board config being merged with it. That applies to the first 3 of the
entries you disable, leaving only CONFIG_SCSI that could potentially be
dealt with that way...

Thanks,
    Paul
