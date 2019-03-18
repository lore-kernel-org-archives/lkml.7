Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E438213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JX5aa3aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCRX1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:27:52 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:63103
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfCRX1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSiO9rkUr5xxkp8HquyhlZeqpKz4AZ606H01e7YidOQ=;
 b=JX5aa3aRoPtgP+GABKO8N4aPNL+9Ps5ph3xi8zce/eDZ+j88vawN3r1OMkqlOej+wv3l7j7Mm0/ShK6FiYMp4mJ6lP9WKGeYvbkmzNFYy1Z6t2gNBBXHGGHHr3La9bNFJZUcrHJwItyH5M0T5/L5wI1R3BVgkbS/I+hZYKwMQaw=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3282.eurprd08.prod.outlook.com (52.134.93.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 23:27:47 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 23:27:47 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, nd <nd@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Swati Sharma <swati2.sharma@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Vidya Srinivas <vidya.srinivas@intel.com>
Subject: Re: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Topic: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Index: AQHU2P+qA2ep7AXS+0OoMG0/Q7/SaqYRNbSAgABaAgCAACqQAIAAWB0A
Date:   Mon, 18 Mar 2019 23:27:47 +0000
Message-ID: <20190318232746.GA32276@arm.com>
References: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
 <dea64e97-1d6b-e728-1e1c-3880e2f0a2e8@linux.intel.com>
 <20190318154004.2llnsarwx77kyqbf@DESKTOP-E1NTVVP.localdomain>
 <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
In-Reply-To: <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f475050-fab4-485d-3916-08d6abf9548c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3282;
x-ms-traffictypediagnostic: AM0PR08MB3282:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3282BEC5FC1FA849769B3398E4470@AM0PR08MB3282.eurprd08.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(305945005)(316002)(4326008)(6246003)(6512007)(53936002)(54906003)(5660300002)(45080400002)(97736004)(2616005)(44832011)(93886005)(476003)(2906002)(229853002)(446003)(76176011)(486006)(99286004)(386003)(6506007)(52116002)(26005)(6436002)(6486002)(478600001)(11346002)(66066001)(6916009)(102836004)(966005)(7416002)(7736002)(72206003)(14454004)(105586002)(1076003)(6306002)(106356001)(186003)(36756003)(71190400001)(71200400001)(8676002)(3846002)(6116002)(81156014)(8936002)(25786009)(81166006)(86362001)(68736007)(256004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3282;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JBOTsh4/suJcdLHRlaGt7m7VprqCcp/o3UL2rRM9Sx1Z1XgYvFqHaHPhxqxbrcdp2tkfP1HZFkZi3TDPVe0Jo3Y+pQOrlc/7W/05wZee/VD3ddIHJsJ3V4UcUVnyzC0J0Hylep3iKtq4BmAfo4zhgOyRDnW4brRfs9d8U4hvcnJhkdJknTDhxm+SIzV432xOBuyjyto0ObOsxEmpslEN1jeEWh5M9ihCqw1NmgCOQpc537hPgBU/S+3FW3pFstnylYu+Pyk5zDuA64aIhApjZgEfK5WHrbuC2CsIdcVAGgFX4TvMx6WSzJC5YplTeHwAgfjvj/3bfwfx7yqKuDKd6W3QFwm7pgMf/EunZkLqrShS6tiqxOcxM+LLbf7LjhUt1PWnikg1FEaDDxo7m/gcX19PJTS+OYxmUPUbnU7TrTE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F64E5A9CD5D36A44A752EB2198DBFC07@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f475050-fab4-485d-3916-08d6abf9548c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 23:27:47.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3282
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:12:24PM +0100, Maarten Lankhorst wrote:
> Op 18-03-2019 om 16:40 schreef Brian Starkey:
> > Hi,
> >
> > On Mon, Mar 18, 2019 at 11:17:55AM +0100, Maarten Lankhorst wrote:
> >
> > <snip>
> >
> >> Hey..
> >>
> >> There's a conflict with this patch and the merge of topic/hdr-formats,=
 resulting in double definitions for Y210, Y410 and P010.
> >>
> >> Worse still is that one has set has_alpha to true for Y41x and other t=
o false.
> >>
> >> ~Maarten
> >>
> > Oh that's sad :-( I think this fell through the cracks on our side
> > when someone left our team. Also turns out I'm not subscribed to
> > igt-dev.
> >
> > I see you commented the same on one of the previous patches, and that
> > there was some discussion of this on the test patches too.
> >
> > I have been referring to Microsoft's page[1] as "the" source for these
> > formats, which does indeed call out Y410 as having 2 bits of alpha.
> > Our GPU expects alpha.
>=20
> Ah. Yeah there has been discussion on whether there was supposed to be al=
pha or not, but the original discussion on HDR formats has been completely =
ignored by arm.
>=20
> The patch had originally a few arm devs on cc and was sent to dri-devel w=
ith linux-media cc'd. Was sad to see it completely ignored so after having =
been sent twice I pushed it.
Apologies, I see that I was cc-ed in the mail 'drm: Add Y2xx and Y4xx
(xx:10/12/16) format definitions and fourcc' sent by
swati2.sharma@intel.com. It got lost in my pile of unread mails. :(

About this patch, I had tagged you in irc channel
(https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highli=
ght_names=3D&date=3D2019-03-11&show_html=3Dtrue)
for reviewing this seies. Did not hear back from you then ?
>=20
> > Was there a specific reason for opting to change the test instead of
> > the definition? Any way to get this changed now?
> >
> > It doesn't seem that sensible for the kernel to call something Y410
> > which doesn't match an "existing" definition by the same name. If
> > alpha needs to be ignored on scanout, the alpha blend mode property
> > can be used (more archaeology - I see that was still giving CRC
> > failures, but that might be a "known issue" for all YUV on your HW?)
>=20
> Were a few bugs, but should be fixed now. :)
>=20
> Well only that we didn't have hw supporting alpha, and didn't hear back f=
rom others so we went without alpha.
In light of the suggestions made by brian.starkey@arm.com, I think
changing the format from Y410 to X410 (in your case) might make sense
as the alpha bits are absent.
If this suggestion looks reasonable to you, I can volunteer myself to make
this change in topic/hdr-formats.
>=20
> > -Brian
> >
> > [1] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-an=
d-16-bit-yuv-video-formats#444-formats
>=20
