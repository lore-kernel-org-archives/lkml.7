Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B7DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E67420679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="T4ygXxdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436493AbfJWPzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:55:53 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:2584 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406949AbfJWPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:55:53 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9NAL0M6002468;
        Wed, 23 Oct 2019 11:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ksjrXEe15nkGU+xC4crL27vTHnHbUiytUo/RO1rQ+IE=;
 b=T4ygXxdibEBmG+AYQFR27trpLqSMKbmh/T6hr9stVg0pXqQFJsKjxnLOpi9TXyMFVbuU
 9mTbYVEt+XvthYaR9TyJMp8Mf9LjoIgbzt7hoMVQ9NRAbVbbZujuMwovpO2pPa2jgRom
 Jww8JDDBQSOf5V0AeK/YJIVxa+mge1wjPfVPV5v6MVhqia4LxMgDofTEwGJH5RyiZcdL
 77uStMglx47456hedbLhN4DSnXbE2UmBcQB6PWwa8GDic1BtPi/n/En/V7dnYctLc3NJ
 T0S0NZ9127HXU+iUPA5hoI4zdFKdn0HjLxtz5+NHCHEx1e8unJ0bIkiPCykPUqEuUVDt qA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2vt63qw1ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 11:55:52 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9NFmKDO092508;
        Wed, 23 Oct 2019 11:55:51 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2vt9tbpn9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 11:55:51 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1368098579"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <oneukum@suse.com>,
        <ckellner@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/25] thunderbolt: Add support for USB4
Thread-Topic: [PATCH 00/25] thunderbolt: Add support for USB4
Thread-Index: AQHViZQfPWLNvQM6tUa0XjXxJxhgq6doYGYg
Date:   Wed, 23 Oct 2019 15:55:48 +0000
Message-ID: <816be093556b466ebb4c645c9933bbc3@AUSX13MPC105.AMER.DELL.COM>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-23T15:55:46.3145766Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_04:2019-10-23,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910220143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> I did not yet add the hw_vendor_id and hw_product_id attributes because I
> clocked that 'dd if=3Dnvm_activeX/nvmem of=3D/dev/null bs=3D64 count=3D2'=
 (that's
> what fwupd does) takes typically less than 10 ms when the controller is p=
owered
> on. That should not slow down fwupd. We can add them later if it is reall=
y a
> problem (I'm just trying to avoid adding too much attributes that we need=
 to
> maintain forever).

Maybe the controller going into D3 is the key to why it measured slow for m=
e when
I checked.

>=20
> I think patches 1 to 17 can be applied for v5.5 already since they are pr=
etty much
> about adding support for existing Thunderbolt 3 devices to the software
> connection manager. This allows Apple systems with Alpine or Titan Ridge
> controller to work without need to start the firmware. Please let me know=
 if
> there are objections.
>=20
> USB4 support patches 18 - 25 have been tested on development hardware but
> since it is rather early stage hardware we have not been able to properly=
 test all
> features such as power management (which is why it is currently missing i=
n this
> series).
>=20
> Mika Westerberg (22):
>   thunderbolt: Introduce tb_switch_is_icm()
>   thunderbolt: Log switch route string on config read/write timeout
>   thunderbolt: Log error if adding switch fails
>   thunderbolt: Convert basic adapter register names to follow the USB4 sp=
ec
>   thunderbolt: Convert PCIe adapter register names to follow the USB4 spe=
c
>   thunderbolt: Convert DP adapter register names to follow the USB4 spec
>   thunderbolt: Make tb_sw_write() take const parameter
>   thunderbolt: Add helper macro to iterate over switch ports
>   thunderbolt: Refactor add_switch() into two functions
>   thunderbolt: Add support for lane bonding
>   thunderbolt: Add default linking between lane adapters if not provided =
by
> DROM
>   thunderbolt: Expand controller name in tb_switch_is_xy()
>   thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Rid=
ge
>   thunderbolt: Add Display Port CM handshake for Titan Ridge devices
>   thunderbolt: Add Display Port adapter pairing and resource management
>   thunderbolt: Add bandwidth management for Display Port tunnels
>   thunderbolt: Do not start firmware unless asked by the user
>   thunderbolt: Make tb_find_port() available to other files
>   thunderbolt: Call tb_eeprom_get_drom_offset() from tb_eeprom_read_n()
>   thunderbolt: Add initial support for USB4
>   thunderbolt: Update Kconfig entry to USB4
>   thunderbolt: Update documentation with the USB4 information
>=20
> Rajmohan Mani (3):
>   thunderbolt: Make tb_switch_find_cap() available to other files
>   thunderbolt: Add support for Time Management Unit
>   thunderbolt: Add support for USB 3.x tunnels
>=20
>  .../ABI/testing/sysfs-bus-thunderbolt         |  28 +
>  Documentation/admin-guide/thunderbolt.rst     |  25 +-
>  drivers/Makefile                              |   2 +-
>  drivers/net/Kconfig                           |   2 +-
>  drivers/thunderbolt/Kconfig                   |  11 +-
>  drivers/thunderbolt/Makefile                  |   4 +-
>  drivers/thunderbolt/cap.c                     |  17 +-
>  drivers/thunderbolt/ctl.c                     |   8 +-
>  drivers/thunderbolt/eeprom.c                  | 146 +--
>  drivers/thunderbolt/icm.c                     | 157 +--
>  drivers/thunderbolt/lc.c                      | 193 +++-
>  drivers/thunderbolt/nhi.c                     |   3 +
>  drivers/thunderbolt/nhi.h                     |   2 +
>  drivers/thunderbolt/path.c                    |  52 +-
>  drivers/thunderbolt/switch.c                  | 943 +++++++++++++++---
>  drivers/thunderbolt/tb.c                      | 536 ++++++++--
>  drivers/thunderbolt/tb.h                      | 182 +++-
>  drivers/thunderbolt/tb_msgs.h                 |   2 +
>  drivers/thunderbolt/tb_regs.h                 | 160 ++-
>  drivers/thunderbolt/tmu.c                     | 383 +++++++
>  drivers/thunderbolt/tunnel.c                  | 527 +++++++++-
>  drivers/thunderbolt/tunnel.h                  |  19 +-
>  drivers/thunderbolt/usb4.c                    | 763 ++++++++++++++
>  drivers/thunderbolt/xdomain.c                 |  11 +-
>  24 files changed, 3718 insertions(+), 458 deletions(-)  create mode 1006=
44
> drivers/thunderbolt/tmu.c  create mode 100644 drivers/thunderbolt/usb4.c
>=20
> --
> 2.23.0

