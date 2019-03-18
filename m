Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45356C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A1220989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jmofvs9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCRTBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:01:44 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:4418
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfCRTBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+UddKJGxYbdqcEcgImuOFVaM3mTl9RECFA3aYT+IR0=;
 b=Jmofvs9VrHaBgH5gMHDv1tbxvjk1INFTnl7Qltz1cBb3+JLaoOW3fpgseVO9Q3dkYhPs0R+AeIP78/dfF/iVp3rbMctQSZlNa1r4ajsZbCseixq+BhyVyG8oKJ9KmnxclwWl8ojcbLro2piHLnJ2Lh5pPTkYw04rOIbPdNjV7Y0=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB4434.eurprd08.prod.outlook.com (20.179.35.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 19:00:57 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 19:00:57 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC:     Ayan Halder <Ayan.Halder@arm.com>,
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
Thread-Index: AQHU2P+qA2ep7AXS+0OoMG0/Q7/SaqYRNbSAgABaAgCAACqQAIAADY8A
Date:   Mon, 18 Mar 2019 19:00:57 +0000
Message-ID: <20190318190056.kr7vvgi5qqaiv6qi@DESKTOP-E1NTVVP.localdomain>
References: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
 <dea64e97-1d6b-e728-1e1c-3880e2f0a2e8@linux.intel.com>
 <20190318154004.2llnsarwx77kyqbf@DESKTOP-E1NTVVP.localdomain>
 <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
In-Reply-To: <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d5c5449-7ee9-43ce-3fdd-08d6abd40da3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4434;
x-ms-traffictypediagnostic: AM0PR08MB4434:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB4434D0F6796B52D3F5BE3B1BF0470@AM0PR08MB4434.eurprd08.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(1076003)(386003)(76176011)(6506007)(305945005)(186003)(966005)(7416002)(86362001)(68736007)(8676002)(45080400002)(7736002)(52116002)(53936002)(6246003)(6916009)(8936002)(256004)(26005)(14454004)(102836004)(5660300002)(105586002)(106356001)(316002)(6512007)(6306002)(66066001)(9686003)(3846002)(97736004)(6116002)(6486002)(229853002)(4326008)(6436002)(72206003)(71190400001)(71200400001)(25786009)(486006)(11346002)(476003)(58126008)(93886005)(81166006)(54906003)(99286004)(446003)(478600001)(44832011)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4434;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dNFDeXjQCUCnLj75U+FeH+4FHI8O3bnJ0X71HLdhTLAAlRzaYi4VQmo/wh+j65gfQzu6plBNYFP4777htmxX1msvu8OQdOQLVvZQwgrcy/p9rwZ+6+j8rcWjXH5CSjM0X1Lbn+BBT5y6vvBdmVEN4zgtAuhreiSeAry8CTsVooVV0QQOkhoLJ/k4911nYr8I9lg4+PbhvrS8NBFDYwraeJ15wJA0SsFbvWHudr5D39mPMqZKo6/sOLHrt3nrhCLgcX6EHPfERyHnVr6jxho6fCx9busrp1msRa/5hOgSfPV7YJZzAVX7J7Tx3QY/uR085jcrW0pqdV+JxxhFzuAHN2skgSKV8O3VKhxn3M/D3mnLljPDoEkIPFT13z8JS6FKmm4x9Z/SMoXXQPQnD/YjgyiuTEiKeml7bdzZ5B5sYFM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4BEB8E7859FCE4D9A82B496D73773AB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5c5449-7ee9-43ce-3fdd-08d6abd40da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 19:00:57.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4434
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

That's the kernel patch(es)? It looks like I did receive them via
dri-devel, and Ayan was Cc'd on two of the series', but it's
disingenuous to say they had "a few Arm devs".

I first submitted this patch with Y410 to dri-devel back in August,
and since then it's been sent 8 times by my count (with you on Cc on
all of them!), and all have been similarly completely ignored; so I'm
sorry but I don't think you can put the blame entirely with Arm here.

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

So what do you suggest? Can we change it, or we need to forever live
with divergent definitions in DRM vs elsewhere?

Gstreamer appears to have a Y410 definition including alpha[1], and
there's the aforementioned Microsoft page too.

To me it looks like we should change DRM, and if your HW supports
something that's "almost but not quite" Y410 then you need a different
name or only allow alpha-blend-mode "none".

Thanks,
-Brian

[1] https://gitlab.freedesktop.org/gstreamer/gst-plugins-base/commit/0ac7d1=
187b234e86157ad74937c249a3c016807c
>=20
> > -Brian
> >
> > [1] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-an=
d-16-bit-yuv-video-formats#444-formats
>=20
>=20
