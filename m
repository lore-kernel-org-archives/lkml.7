Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04608C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DF02086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="mi7CvzOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbfJAORH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:17:07 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:15328 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388825AbfJAORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:17:06 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91EF6RM021840;
        Tue, 1 Oct 2019 10:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lb3EjCOPwXNnbIrJTAvQSaTDPpughxVrvt+AFocqr1k=;
 b=mi7CvzOi7ZGME/RXa9/n21j+8uHGrgu0BSdxXwoE2IdNF+Tc1K8fnepPp9TSM8Z2rhy7
 P/yxhhwAIoTAGk9d4mgdSZ9wDy9O/gdmgl86q+ct2XGCyzm4MhUYCP8qW8WwcBv5mJ5v
 JAhe6/Lu+IRQRiJgZmHN6jjJGOBYbg7qkHivnHmo40r3dsy2VVupuKVB3ayrDmUQaXX9
 hstFES1tfVkstTmzEEjGh3aI47LePqleagVf0bi9FwZnveeDo3+VK7yB/FgmRvBurtTO
 ET+cfM8INxCtAoXEQgTkWcLSrDoOVisqVT9LX98fZXq0DqszkkPuRy9ulvaGmWF388w8 1Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2nynreb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 10:17:05 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91EDgSx134661;
        Tue, 1 Oct 2019 10:17:05 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2vc2runhc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 10:17:04 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1304919345"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 21/22] thunderbolt: Update documentation with the USB4
 information
Thread-Topic: [RFC PATCH 21/22] thunderbolt: Update documentation with the
 USB4 information
Thread-Index: AQHVeEzL3WE1QvUi2E22g7+V7paqBqdF082g
Date:   Tue, 1 Oct 2019 14:17:01 +0000
Message-ID: <5d628533d75b4b00a26c868012d5e5df@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-22-mika.westerberg@linux.intel.com>
In-Reply-To: <20191001113830.13028-22-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T14:16:57.9266431Z;
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010128
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910010128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Tuesday, October 1, 2019 6:38 AM
> To: linux-usb@vger.kernel.org
> Cc: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat; Rajm=
ohan
> Mani; Nicholas Johnson; Lukas Wunner; Greg Kroah-Hartman; Alan Stern;
> Limonciello, Mario; Anthony Wong; linux-kernel@vger.kernel.org
> Subject: [RFC PATCH 21/22] thunderbolt: Update documentation with the USB=
4
> information
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Update user's and administrator's guide to mention USB4, how it relates
> to Thunderbolt (it is public spec of Thunderbolt 3) and and how it is
> supported in Linux.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  Documentation/admin-guide/thunderbolt.rst | 27 ++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/ad=
min-
> guide/thunderbolt.rst
> index 898ad78f3cc7..4cbed319133d 100644
> --- a/Documentation/admin-guide/thunderbolt.rst
> +++ b/Documentation/admin-guide/thunderbolt.rst
> @@ -1,6 +1,25 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Thunderbolt
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + Thunderbolt and USB4
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +USB4 is the public spec of Thunderbolt 3 with some differences at the
> +register level among other things. There are two different
> +implementations available: firmware connection manager and software
> +connection manager. Typically PCs come with a firmware connection
> +manager for Thunderbolt 3 and early USB4 capable systems. Apple systems
> +on the other hand use software connection manager and the future USB4
> +compliant PCs follow the suit.

Future isn't going to age very well.  Perhaps refer instead to "later" USB4=
 compliant
PCs.

Also, we should be seeing this stuff pop-up outside of PCs.  So maybe bette=
r
to just call out "devices".

> +
> +The Linux Thunderbolt driver supports both and can detect at runtime
> +which connection manager implementation is to be used. To be on the safe
> +side the software connection manager in Linux also advertises security
> +level ``user`` which means PCIe tunneling is disabled by default. The
> +documentation below applies to both implementations with the exception
> +that the software connection manager only supports ``user`` security
> +level and is expected to be accompanied with an IOMMU based DMA
> +protection.
> +
> +Security levels and how to use them
> +-----------------------------------
>  The interface presented here is not meant for end users. Instead there
>  should be a userspace tool that handles all the low-level details, keeps
>  a database of the authorized devices and prompts users for new connectio=
ns.
> @@ -18,8 +37,6 @@ This will authorize all devices automatically when they
> appear. However,
>  keep in mind that this bypasses the security levels and makes the system
>  vulnerable to DMA attacks.
>=20
> -Security levels and how to use them
> ------------------------------------
>  Starting with Intel Falcon Ridge Thunderbolt controller there are 4
>  security levels available. Intel Titan Ridge added one more security lev=
el
>  (usbonly). The reason for these is the fact that the connected devices c=
an
> --
> 2.23.0

