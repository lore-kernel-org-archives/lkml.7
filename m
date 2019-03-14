Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E058D21855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lhTZClfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCNRpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:45:04 -0400
Received: from mail-eopbgr770121.outbound.protection.outlook.com ([40.107.77.121]:7552
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbfCNRpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgOdmU3bcjakni9K4UNutpjAm3DVWPTAkT5CO5Wc/ws=;
 b=lhTZClfhmo+/wzF5QJNkDefiggb1OHIcjyTPwFzWhRiQz+LQrpgafZ6SusV2T9gG33djTTU1QehYqJefJHanBwWKnbGBy4miiBj7DWqf4EoCoi2QvL009046q/F7kJTX4h69f8JwULE0qn/6EUHI0RoX1+noowonVYINDrHRB/I=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1565.namprd22.prod.outlook.com (10.172.63.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 17:45:00 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 17:45:00 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Jan Kara <jack@suse.cz>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>
Subject: Re: fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro
 'pr_warn_ratelimited'
Thread-Topic: fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro
 'pr_warn_ratelimited'
Thread-Index: AQHU2kE9TNc9Xz/Ru02GAeQ2iPZMrqYLBsAAgAAKToCAAB/LAIAAHTuAgAAYs4A=
Date:   Thu, 14 Mar 2019 17:45:00 +0000
Message-ID: <20190314174458.ncy47p6ybwc5cgg6@pburton-laptop>
References: <201903140234.4FpTWdW3%lkp@intel.com>
 <20190314083758.GA16658@quack2.suse.cz>
 <CAOQ4uxhZH9=U63J1_bVrMbNO-Quy-8S300Qi6VmZxvKwYCogQQ@mail.gmail.com>
 <20190314123811.GH16658@quack2.suse.cz>
 <20190314143158.GC27249@linux-mips.org>
 <CAOQ4uxiEkczB7PNCXegFC-eYb9zAGaio_o=OgHAJHFd7eavBxA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiEkczB7PNCXegFC-eYb9zAGaio_o=OgHAJHFd7eavBxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4b5f40d-8316-49e7-e21b-08d6a8a4c7d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1565;
x-ms-traffictypediagnostic: MWHPR2201MB1565:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR2201MB15657B12E340B54634A4C315C14B0@MWHPR2201MB1565.namprd22.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39850400004)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(99286004)(25786009)(478600001)(81166006)(8676002)(53936002)(14454004)(4326008)(66066001)(52116002)(68736007)(81156014)(6506007)(6306002)(386003)(6246003)(76176011)(1076003)(9686003)(6512007)(1411001)(5660300002)(71190400001)(6916009)(71200400001)(26005)(102836004)(44832011)(106356001)(316002)(93886005)(97736004)(7736002)(105586002)(486006)(53546011)(305945005)(33716001)(54906003)(8936002)(966005)(6436002)(11346002)(256004)(14444005)(3846002)(58126008)(229853002)(2906002)(446003)(6116002)(476003)(42882007)(186003)(6486002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1565;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 464bcoS57sCl4QG8MTqxrlpFf5eIKFg/UQB6w8IKHfRoEgo8oQTvGi/JpfHeiYo7yZyxq8qOhGliHB07k8boNfurS7Py4K4ynwBXpyZf084QZiZObpKioPm6NBdHjjyEbyJLfNbFiKG7JV62o9H135H/OhdYIFxr52gft4uSnCbwQwEucJeSmQ8wXKaXPcHad1xG7YYlsaoLGFOduU8YvQ/YFWQnE03a4sDOhHE+9IqvwBDdQT4xv4OKMaO8j9ie/ohDoixft741RyxKgaJ7iL1z3Nl3IDasnj3tWioNUhMUpQ24PaAJS1bS5YvT/t1d2JTZp60vGrJkwmLHeJSksHFZiYdrw7G0THje8E+ZZ3l+JgLhDdkLCqlmhnLXVXZ3LQER0YqZm3VWf0mFxY9stUOrQlzk58F573umykva3Vw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71CCCE8217C4A74EAF907C5A7E6A7264@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b5f40d-8316-49e7-e21b-08d6a8a4c7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 17:45:00.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amir,

On Thu, Mar 14, 2019 at 06:16:35PM +0200, Amir Goldstein wrote:
> On Thu, Mar 14, 2019 at 4:34 PM Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Thu, Mar 14, 2019 at 01:38:11PM +0100, Jan Kara wrote:
> > > On Thu 14-03-19 14:01:18, Amir Goldstein wrote:
> > > > On Thu, Mar 14, 2019 at 10:37 AM Jan Kara <jack@suse.cz> wrote:
> > > > > AFAICS this is the known problem with weird mips definitions of
> > > > > __kernel_fsid_t which uses long whereas all other architectures u=
se int,
> > > > > right? Seeing that mips can actually have 8-byte longs, I guess t=
his
> > > > > bogosity is just wired in the kernel API and we cannot easily fix=
 it in
> > > > > mips (mips guys, correct me if I'm wrong). So what if we just
> > > > > unconditionally typed printed values to unsigned int to silence t=
he
> > > > > warning?
> > > >
> > > > I don't understand why. To me that sounds like papering over a bug.
> > > >
> > > > See this reply from mips developer Paul Burton:
> > > > https://marc.info/?l=3Dlinux-fsdevel&m=3D154783680019904&w=3D2
> > > > mips developers have not replied to the question why __kernel_fsid_=
t
> > > > should use long.
> > >
> > > Ah, right. I've missed that mips defines __kernel_fsid_t only if
> > > sizeof(long) =3D=3D 4. OK, than fixing MIPS headers is definitely wha=
t we ought
> > > to do. Mips guys, any reason why the patch from Ralf didn't get merge=
d yet?
> >
> > Paul's patch :-)
> >
> > As for the reason why the definition is as it is - 32-bit MIPS was
> > born using long, then in 2000 64-bit MIPS started off as arch/mips64
> > using int.  Eventually the two ports were combined using:
> >
> > ypedef struct {
> > #if (_MIPS_SZLONG =3D=3D 32)
> >         long    val[2];
> > #endif
> > #if (_MIPS_SZLONG =3D=3D 64)
> >         int     val[2];
> > #endif
> > } __kernel_fsid_t;
> >
> > A desparate attempt to use asm-generic where ever possible then resulte=
d
> > in the confusing definition we'e having today.
> >
> > Normally APIs are cast into stone not to be changed.  But fsid is used =
in
> > struct statfs and the man page states "Nobody knows what f_fsid is supp=
osed
> > to contain (but see below)." and f_fsid is supposed to be opaque anyway=
 so
> > I'm wondering if something could break at all.  Researching that.
> >
>=20
> Its content is opaque, but its size must be equal to that of fsid_t
> from glibc/toolchain headers. Do the mips32 glibc headers also
> define fsid_t as long val[2], or do they define it as int val[2]?

First off, my apologies that my proposed patch slipped through the
cracks. It somehow didn't make it onto my to-do list & after that there
was little chance I was going to remember it until someone replied... :)

I've just polished off the patch & submitted it [1]. Presuming nobody
has a problem with it in the next couple of days, I'll apply it to
mips-fixes & send it on to Linus.

To address your question about glibc headers - it shouldn't matter. On
MIPS32 int & long are the same, so even if userland & the kernel
disagree about the type the data in memory should be identical.

[1] https://lore.kernel.org/linux-mips/20190314173900.25454-1-paul.burton@m=
ips.com/T/#u

Thanks,
    Paul
