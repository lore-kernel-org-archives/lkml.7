Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182A82084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="dIl7LXrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCRLzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:55:16 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:48894 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbfCRLzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:55:16 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id AE/0C-06417-0278F8C5; Mon, 18 Mar 2019 11:55:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfXfO5tHcOs7Cx5FdFkGZZ7nMWvQ
  lKGh9EArKJAw9myc32KZus5YUWWEzx5oJ3YbXMqNpREZgGmXSzVkkc1hKZaMZZQ7FWprYZWdn
  lX37Pc///z6Xl4fAxHcFEoKxmBmjgdZJBbG4Zg1aRy2xOnLSTvRuUjysCWKKsz6/QPHNW8FT9
  HfUCDbjyjvON9HKk98PKNtcpwTKL22Ld+B7+VqDqtCSx9dMuQ4UfcMsPZeTypALq0SxBE7ewG
  Dy5yucDcTkaR5cDNwXcMEwghPBwVAQQwhIOdSNjSOWF5BboLKjPGzCSDeCkU/3eJWIIBJIGjo
  HCzmPCnoHxngcr4XXdbNhxskV0DTdEGYhuQ+efhzksywmFTBS+w5jOYbcCGeG2nCWEZkMX4+1
  hPMYmQhD/vrwWyBJaLr7AuN4IXx6/5PP+XPBej8QzeVT4flLP+JYCs2vnHyOk8FTb4vkMyHYW
  BHeBcghBK0vzuOckAKzrooI66C8uibyYBH0P22MDPGGDw+al3ELqGGi9nmk8WJw2X04V7QPA8
  +jAOI2SIWGzkkBx6uhufEzVoVWOucs55xjc86xOcMfFg89F/14A8JdSKEyags0Zj2t1VHytDR
  KLk+nMqiMdBldSqlkTAmlZgxmIx0SZfRBk8x0SK/W5csMjLkNhS4pv5if0Y4C1oJulETwpAuF
  8aWOHLFIVZh/SEObNLnGEh1j6kaLCEIKwvflIS3eyBQwlv1aXegc/8hAxEkXCD2sLDQV0XqTt
  oCT3Igiui75ajExbig0MJJE4XXWRLImTYnhb4k/R+1ByZIEIYqKihLHFTFGvdb8vz6KEgkkTR
  AuPxmqEqc1mP92Gg0NwQsN0XrNxg5hpv9JkjJUat/+drj/8Ax15aF6/dD01Q0+54xXfzOzSyT
  yXh175q4aVXywBSy3scZs67ljzfOOFzXYbbYnuwY8jqSopUSHe3e3PvPaVruVqC7LLj6KAj/2
  TLbM/zB+y9GUFR3bc0QU7OibGqlYW1efNfx4wy/sws7y9Hafd97EtkeVq3ry9ktxk4aWp2BGE
  /0bIOd8bs8DAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-27.tower-239.messagelabs.com!1552910111!2714954!1
X-Originating-IP: [104.47.1.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16718 invoked from network); 18 Mar 2019 11:55:11 -0000
Received: from mail-ve1eur01lp2052.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.52)
  by server-27.tower-239.messagelabs.com with AES256-SHA256 encrypted SMTP; 18 Mar 2019 11:55:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qyI0zlSLw8p9Azf11u21V+iy3yQfiGIqYq6NckLa2U=;
 b=dIl7LXrK+ACHQMdo0/dxeQ7ysQyxILoulPGASvcmzq5EF+NgTLYAChTNo163LrbWzCYH41nR4/xGNpc8PPquudcEwjG8xk8rlVyIfH9thvndG6Vixn24pmm45RsNf4uMrqyCma1O7dnLk8j4X6ghHSpfpOlW4BC1oxYl0KUf4cQ=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2190.EURPRD10.PROD.OUTLOOK.COM (20.177.60.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 11:55:10 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 11:55:09 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9052: Include linux/of.h to fix build
 warning for of_match_ptr
Thread-Topic: [PATCH] regulator: da9052: Include linux/of.h to fix build
 warning for of_match_ptr
Thread-Index: AQHU25qute7xczazPkCWVkzl7ffApKYRSwgA
Date:   Mon, 18 Mar 2019 11:55:09 +0000
Message-ID: <VI1PR10MB2352C0E73E6C322312012AE2FE470@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190316015030.11522-1-axel.lin@ingics.com>
In-Reply-To: <20190316015030.11522-1-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1249b566-003b-44f8-adb3-08d6ab98924d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2190;
x-ms-traffictypediagnostic: VI1PR10MB2190:
x-microsoft-antispam-prvs: <VI1PR10MB219090DC97C11DACCC34F43AF5470@VI1PR10MB2190.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(33656002)(7696005)(14444005)(2906002)(25786009)(76176011)(256004)(53546011)(6506007)(186003)(99286004)(14454004)(106356001)(478600001)(81156014)(81166006)(54906003)(8676002)(316002)(229853002)(6436002)(4326008)(8936002)(6116002)(102836004)(3846002)(7736002)(305945005)(26005)(110136005)(5660300002)(9686003)(486006)(86362001)(446003)(71200400001)(71190400001)(74316002)(4744005)(6246003)(52536014)(53936002)(68736007)(97736004)(11346002)(66066001)(476003)(55016002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2190;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +3TUdYC7noti53RMY2z2WxBfW9o3cHxQusoQz95B7JeBkehVq/KotL+16K6N0RT+5Fc5xxZeC1SmHdOu6OmQVH1vPlkKizcp1MtmMD4XmM2nl7oNLBQr5tqJ0adnX2/1ipAo1JBaf8U2gGueLYbtTUYJbEO9qwjdwg60s+cMXt9JLRZ7TfaQg2KsZj2zRedtHgAhuUih5nH6i9q41zWrWngBVMtFOEBYPCgK9H+n+hHeehmFKskVCGZjhHis0/92H/17+hoXX0dyGUo+Uks7PgtskOit0P5Mj1ON8X+8wOtvd1BIg+w59ZXPmJ3mRxamoVMGod4FuMFzRar/cWKE4B2D469x17ufJKRqScBn9iP2TTRNQQcR9X/pj+Nu0Nggi17qfi1v/mo/8toLVgrSwEHfTwxkdZxCZKq14pQDH74=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1249b566-003b-44f8-adb3-08d6ab98924d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 11:55:09.6696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On 16 March 2019 01:51,  Axel Lin wrote:

> To: Mark Brown <broonie@kernel.org>
> Subject: [PATCH] regulator: da9052: Include linux/of.h to fix build warni=
ng for
> of_match_ptr
>=20
> Remove #ifdef CONFIG_OF guard so linux/of.h will be included when
> !CONFIG_OF. This fixes build warnings when !CONFIG_OF.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks!

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

