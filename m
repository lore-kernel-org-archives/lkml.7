Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E59C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD36B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aabYIwMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCRTGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:06:45 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:25535
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbfCRTGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUhMOKQifGyBq9dcxUBuvsf8TfK5pJetvZrfGC8ZiRc=;
 b=aabYIwMFEpIrU7jGrGWu36hQMQa32tcRvEpHQKNtvP9jgEk9icnE4nEf4zG1haY3gUnHjpt8WV4b4pwZx4Dr+nfbYUT0brH9kMlGvRa/+1A7KR57NYtqgdS9pnCCCspNYq/bL0aVPe2WN8xLtepRhhz+aHaZ7IJVd1QdxTKU9Oo=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB4434.eurprd08.prod.outlook.com (20.179.35.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 19:06:40 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 19:06:40 +0000
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
Thread-Index: AQHU2P+qA2ep7AXS+0OoMG0/Q7/SaqYRNbSAgABaAgCAACqQAIAADY8AgAABmAA=
Date:   Mon, 18 Mar 2019 19:06:39 +0000
Message-ID: <20190318190638.ryv53gkh3skmajp2@DESKTOP-E1NTVVP.localdomain>
References: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
 <dea64e97-1d6b-e728-1e1c-3880e2f0a2e8@linux.intel.com>
 <20190318154004.2llnsarwx77kyqbf@DESKTOP-E1NTVVP.localdomain>
 <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
 <20190318190056.kr7vvgi5qqaiv6qi@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190318190056.kr7vvgi5qqaiv6qi@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LNXP265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::18) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4b7431d-43da-4482-a906-08d6abd4d9f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4434;
x-ms-traffictypediagnostic: AM0PR08MB4434:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB44344985C7D9AAFB95ED8ADDF0470@AM0PR08MB4434.eurprd08.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(1076003)(386003)(76176011)(6506007)(305945005)(186003)(966005)(7416002)(86362001)(68736007)(8676002)(45080400002)(7736002)(52116002)(53936002)(6246003)(6916009)(8936002)(256004)(26005)(14454004)(102836004)(5660300002)(105586002)(106356001)(316002)(6512007)(6306002)(66066001)(9686003)(3846002)(97736004)(6116002)(6486002)(229853002)(4326008)(6436002)(72206003)(71190400001)(71200400001)(25786009)(486006)(11346002)(476003)(58126008)(93886005)(81166006)(54906003)(99286004)(446003)(478600001)(44832011)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4434;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hjbxGx4/NHAkDT/D06XG06BD7NyOpFb/k9KKV5IkhMzarBKvNrzVoH6yCPVPzIolKVGDxJNQ9jra5e2SAxpIH0Zvml42EqymWaGQIMS8TexKjr8GJBAW9xTMC4Kvx3texVslsI9hwpIZWtZ6wIQ9yGMroU6jpyalKUzQa8gaGYAHwrxIp9mP7rTZy+0vgOsao3HCzwf6Tj4PGgguko35DjKkF0J64B4JH83J3rt6XAskBdIjqyox9Uq21yTR6yQ4ONd9E8gCBVTDpCRJOdxkzt2RMZxK9F8jIXdQ6b51yy9WjQmMieoRwR1y4xO+lGEieu9C8IiMz1HsBKH0TXYtykMbaHeA9bvXanryVxy3KmEhmkbkelG489+BwA1/g+P9xSyb0pI4nBQGqIfXaTZQ7NN6w5jg+FMjvQ0GtUmvHZc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A6AA8735F13C24EAE9F04B8B1DDBB45@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b7431d-43da-4482-a906-08d6abd4d9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 19:06:40.0052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:00:57PM +0000, Brian Starkey wrote:
> On Mon, Mar 18, 2019 at 07:12:24PM +0100, Maarten Lankhorst wrote:
> > Op 18-03-2019 om 16:40 schreef Brian Starkey:
> > > Hi,
> > >
> > > On Mon, Mar 18, 2019 at 11:17:55AM +0100, Maarten Lankhorst wrote:
> > >
> > > <snip>
> > >
> > >> Hey..
> > >>
> > >> There's a conflict with this patch and the merge of topic/hdr-format=
s, resulting in double definitions for Y210, Y410 and P010.
> > >>
> > >> Worse still is that one has set has_alpha to true for Y41x and other=
 to false.
> > >>
> > >> ~Maarten
> > >>
> > > Oh that's sad :-( I think this fell through the cracks on our side
> > > when someone left our team. Also turns out I'm not subscribed to
> > > igt-dev.
> > >
> > > I see you commented the same on one of the previous patches, and that
> > > there was some discussion of this on the test patches too.
> > >
> > > I have been referring to Microsoft's page[1] as "the" source for thes=
e
> > > formats, which does indeed call out Y410 as having 2 bits of alpha.
> > > Our GPU expects alpha.
> >=20
> > Ah. Yeah there has been discussion on whether there was supposed to be =
alpha or not, but the original discussion on HDR formats has been completel=
y ignored by arm.
> >=20
> > The patch had originally a few arm devs on cc and was sent to dri-devel=
 with linux-media cc'd. Was sad to see it completely ignored so after havin=
g been sent twice I pushed it.
>=20
> That's the kernel patch(es)? It looks like I did receive them via
> dri-devel, and Ayan was Cc'd on two of the series', but it's
> disingenuous to say they had "a few Arm devs".
>=20
> I first submitted this patch with Y410 to dri-devel back in August,
> and since then it's been sent 8 times by my count (with you on Cc on
> all of them!), and all have been similarly completely ignored; so I'm
> sorry but I don't think you can put the blame entirely with Arm here.
>=20
> >=20
> > > Was there a specific reason for opting to change the test instead of
> > > the definition? Any way to get this changed now?
> > >
> > > It doesn't seem that sensible for the kernel to call something Y410
> > > which doesn't match an "existing" definition by the same name. If
> > > alpha needs to be ignored on scanout, the alpha blend mode property
> > > can be used (more archaeology - I see that was still giving CRC
> > > failures, but that might be a "known issue" for all YUV on your HW?)
> >=20
> > Were a few bugs, but should be fixed now. :)
> >=20
> > Well only that we didn't have hw supporting alpha, and didn't hear back=
 from others so we went without alpha.
>=20
> So what do you suggest? Can we change it, or we need to forever live
> with divergent definitions in DRM vs elsewhere?
>=20
> Gstreamer appears to have a Y410 definition including alpha[1], and
> there's the aforementioned Microsoft page too.
>=20
> To me it looks like we should change DRM, and if your HW supports
> something that's "almost but not quite" Y410 then you need a different
> name or only allow alpha-blend-mode "none".
>=20
> Thanks,
> -Brian
>=20
> [1] https://gitlab.freedesktop.org/gstreamer/gst-plugins-base/commit/0ac7=
d1187b234e86157ad74937c249a3c016807c

Eh. I'm not familiar enough with the gitlab UI. Looks like this didn't
merge in GStreamer so far.

> >=20
> > > -Brian
> > >
> > > [1] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-=
and-16-bit-yuv-video-formats#444-formats
> >=20
> >=20
