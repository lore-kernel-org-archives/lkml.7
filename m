Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6010EC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223332133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="g1fyY4Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCWzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:55:46 -0400
Received: from mail-eopbgr730105.outbound.protection.outlook.com ([40.107.73.105]:6379
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfDCWzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTJbDUk0NbZAslQ7nfZJ6xdXQI7Y/PoZzdXBiiAaQk8=;
 b=g1fyY4VmWyGhmQN6c2jVTt0qoxVSYBYHoNajVJzSibnuZTwJPlvtO1qGRE+ESxOqgTmw025ebWDacTDE7wS5zC4qrQBa5Aw0PSINbxfkW3AJDF+hZKXIu2/6k9ETljSeHgpnqzGBAXhScI5AefjsXZoTpzJ6DSjc0qv6j9n4AR0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1149.namprd22.prod.outlook.com (10.174.165.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Wed, 3 Apr 2019 22:55:41 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%6]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 22:55:41 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's
 option
Thread-Topic: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's
 option
Thread-Index: AQHU6W8DZ8+x/c6YDUSWmnR9oZQ6TqYrDdiA
Date:   Wed, 3 Apr 2019 22:55:41 +0000
Message-ID: <20190403225539.wgytklr6ndpzbrlu@pburton-laptop>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d754c099-9852-4f87-a4f7-08d6b8877ef2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2201MB1149;
x-ms-traffictypediagnostic: MWHPR2201MB1149:
x-microsoft-antispam-prvs: <MWHPR2201MB1149D7A7600E68412804C406C1570@MWHPR2201MB1149.namprd22.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(376002)(346002)(39850400004)(396003)(189003)(199004)(316002)(8936002)(25786009)(229853002)(58126008)(68736007)(305945005)(14454004)(81166006)(81156014)(5660300002)(7736002)(476003)(97736004)(11346002)(66066001)(3846002)(44832011)(106356001)(8676002)(486006)(33716001)(71200400001)(446003)(71190400001)(2906002)(4744005)(53936002)(42882007)(6116002)(256004)(6486002)(186003)(26005)(386003)(9686003)(14444005)(7416002)(6246003)(6436002)(54906003)(6512007)(76176011)(6506007)(1076003)(52116002)(4326008)(99286004)(105586002)(478600001)(6916009)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1149;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HLNkbbUYq9QnUDlu1eRw1cVQlkgKkyIGRuYNymlk6l9ScupInwNSeVtAeMDXXU8l1XFZeAoIPrQdUXszbkEWmzWwfMNNG5CQpbKqcm5jntiHCpMpT64kkkJy8FHWHJiijxEjDojcE3RBvSvP8CXN7m4i8vT/sbYpihFaIcRU1yjheglQZCGBSP8xcSHmY1g/3L+kYYjwRXW0w2vgQVtIfqj2AN7oW6TF3OGqKNkLNMZaVfxWoaywIhZn+05RmfqSuCuUvcFpdxRcXReS4GMx8jqgL5BFauTDWLD4sxJSkLkvTDsG2fFm//C0s4NyOQkRWOPfyls20mU+WS78tzGShohnv1gtOFsHhXpUHJINKBMpno3kPFTdO1HIg2zndNF+3p/q/9+gzrQPkBR7QqJsyzRivnS9Uq52FGoPCPkP9Kc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F76AB0D364FC842ABC1B5D5590BEE17@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d754c099-9852-4f87-a4f7-08d6b8877ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 22:55:41.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Apr 02, 2019 at 06:12:44PM +0200, Daniel Lezcano wrote:
> The module support for the thermal subsystem makes little sense:
>  - some subsystems relying on it are not modules, thus forcing the
>    framework to be compiled in
>  - it is compiled in for almost every configs, the remaining ones
>    are a few platforms where I don't see why we can not switch the therma=
l
>    to 'y'. The drivers can stay in tristate.
>  - platforms need the thermal to be ready as soon as possible at boot tim=
e
>    in order to mitigate

Nit: mitigate what? High temperatures? It feels like this sentence was
cut short.

> Usually the subsystems framework are compiled-in and the plugs are as mod=
ule.
>=20
> Remove the module option. The removal of the module related dead code wil=
l
> come after this patch gets in or is acked.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Guenter Roeck <groeck@chromium.org>
> For mini2440:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS part

Thanks,
    Paul
