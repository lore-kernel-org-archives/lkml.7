Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8131ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7585620842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="mfqSB9qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbfJAO7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:59:15 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:20472 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbfJAO7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:59:14 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91EdswL015326;
        Tue, 1 Oct 2019 10:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=sqH/a2bF4Hj9eML4oBYR/Te05wFz7EleJ/g6nv0L5yw=;
 b=mfqSB9qSt0DiiAWuXM+W5Mi9QVzcUhYWXKrVhbb5J37Ou+VVy30a+xPynHsb48Y0yqA4
 393kHtk/1anCXwn3xvKzC5SiFGBzo996JFoZiqijwn8PuBaIRUk4H3LhmtDM9Jh/9wu5
 XGPG0xOGcPToDWucNebKkpoyCdw4/hnpdd2UvZaAlz+TLAOKthO/R7MvLWUHsC2PfShS
 /MsAf0NHDY2pIyi8lK/ru2ry6TYPILH/kwTrpiT136PWS08GkcBRrMCqVDrtsUp8YnTF
 LmXktUQ4s22z9+wFdKJSGTetQKM57gRuhRM+KKIeUqC9A73AEt4kA0BCv011teIMkw1L gA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2va46nds3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 10:59:09 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91Ebllj052890;
        Tue, 1 Oct 2019 10:59:09 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2va25fg4qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 10:59:08 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="382040259"
From:   <Mario.Limonciello@dell.com>
To:     <gregkh@linuxfoundation.org>, <mika.westerberg@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <stern@rowland.harvard.edu>, <anthony.wong@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGEBMAgAAF8oCAAB1JAP//rPeA
Date:   Tue, 1 Oct 2019 14:59:06 +0000
Message-ID: <924ce4d5862c4d859e238c0e706a3d5b@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <20191001124748.GH2954373@kroah.com>
 <20191001130905.GO2714@lahna.fi.intel.com>
 <20191001145354.GA3366714@kroah.com>
In-Reply-To: <20191001145354.GA3366714@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T14:59:04.7528531Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_07:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910010132
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910010132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 1, 2019 9:54 AM
> To: Mika Westerberg
> Cc: linux-usb@vger.kernel.org; Andreas Noever; Michael Jamet; Yehezkel Be=
rnat;
> Rajmohan Mani; Nicholas Johnson; Lukas Wunner; Alan Stern; Limonciello, M=
ario;
> Anthony Wong; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tue, Oct 01, 2019 at 04:09:05PM +0300, Mika Westerberg wrote:
> > On Tue, Oct 01, 2019 at 02:47:48PM +0200, Greg Kroah-Hartman wrote:
> > > > -	  Thunderbolt Controller driver. This driver is required if you
> > > > -	  want to hotplug Thunderbolt devices on Apple hardware or on PCs
> > > > -	  with Intel Falcon Ridge or newer.
> > > > +	  USB4 (Thunderbolt) driver. USB4 is the public spec based on
> > > > +	  Thunderbolt 3 protocol. This driver is required if you want to
> > > > +	  hotplug Thunderbolt and USB4 compliant devices on Apple
> > > > +	  hardware or on PCs with Intel Falcon Ridge or newer.
> > >
> > > Wait, did "old" thunderbolt just get re-branded as USB4?
> >
> > Not but the driver started supporting USB4 as well :)
> >
> > USB4 is pretty much public spec of Thunderbolt 3 but with some
> > differences in register layouts (this is because Thunderbolt uses some
> > vendor specific capabilities which are now moved to more "standard"
> > places).
>=20
> Ok, then we need to rename the Kconfig option as well, otherwise no one
> will "know" that this changed, so they will not be prompted for it.
>=20
> > > Because if I have an "old" laptop that needs Thunderbolt support, how=
 am
> > > I going to know it is now called USB4 instead?
> >
> > Well the Kconfig option tries to have both names there:
> >
> >   tristate "USB4 (Thunderbolt) support"
> >
> > and then
> >
> >   USB4 (Thunderbolt) driver. USB4 is the public spec based on
> >   Thunderbolt 3 protocol. This driver is required if you want to hotplu=
g
> >   Thunderbolt and USB4 compliant devices on Apple hardware or on PCs
> >   with Intel Falcon Ridge or newer.
> >
> > and the Kconfig option is still CONFIG_THUNDERBOLT. I know this is
> > confusing but I don't have better ideas how we can advertise both. I
> > borrowed this "format" from firewire.
>=20
> CONFIG_USB4 instead?

How about CONFIG_USB4_PCIE?

I think that will help align that certain aspects of USB4 can be built opti=
onally.

>=20
> > > Shouldn't there just be a new USB4 option that only enables/builds th=
e
> > > USB4 stuff if selected?  Why would I want all of this additional code=
 on
> > > my old system if it's not going to do anything at all?
> >
> > USB4 devices are backward compatible with Thunderbolt 3 so you should b=
e
> > able to plug in USB4 device to your old Thunderbolt 3 laptop for
> > example. It goes the other way as well. Some things are optional but fo=
r
> > example USB4 hubs must support also Thunderbolt 3.
> >

If PCIe tunnels are an optional feature in USB4, how can it be mandatory to=
 support
Thunderbolt 3?

> > Does that clarify?
>=20
> Yes, it does, looks like marketing just renamed an old functioning
> system into a "brand new one!" :)
>=20
> thanks,
>=20
> greg k-h
