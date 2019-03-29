Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C27C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B9F20700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="y5/v94JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfC2FXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:23:05 -0400
Received: from mail-eopbgr1300082.outbound.protection.outlook.com ([40.107.130.82]:44089
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfC2FXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSudUcpDQIog0pHRkrpVhh6+fjJHFimXBCOQBKXHF9A=;
 b=y5/v94JVeQN/aTKiWluFm8MHas+CfSeJUJyvxtONfcfgrFzvf0pDKZTkygHiIQUOAe/cSGqkash5ayup5wBcxWwufvhTloZUf/t97MyoLIRD6X4oN+Nn4GTaM5j5aUAfscAz16nVbesfuz7KmoHqCFjJJ07RyxUxA8VorqKhd3M=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3656.apcprd02.prod.outlook.com (20.177.171.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 05:22:55 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 05:22:55 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [External] Re: Print map for total physical and virtual memory
Thread-Topic: [External] Re: Print map for total physical and virtual memory
Thread-Index: AQHU46nCeD1YOwMRP0e9ea2iKxtjwaYdyRyAgAAQFrWAAAJjAIAEO9Qa
Date:   Fri, 29 Mar 2019 05:22:55 +0000
Message-ID: <SG2PR02MB3098156002F7CCC46078B57AE85A0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098F980E1EB299853AC46E6E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190326113657.GL10344@bombadil.infradead.org>
 <SG2PR02MB3098B0C0CD27969FB7C9ECD7E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<20190326124304.GN10344@bombadil.infradead.org>
In-Reply-To: <20190326124304.GN10344@bombadil.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21f4bb91-cb4c-489f-0117-08d6b406992c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB3656;
x-ms-traffictypediagnostic: SG2PR02MB3656:|SG2PR02MB3656:
x-microsoft-antispam-prvs: <SG2PR02MB365687DFE8EFDC0DDEC8F1CAE85A0@SG2PR02MB3656.apcprd02.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39850400004)(136003)(199004)(189003)(55236004)(78486014)(25786009)(7736002)(55016002)(76176011)(102836004)(6916009)(71200400001)(478600001)(66066001)(4326008)(105586002)(71190400001)(6436002)(6506007)(486006)(9686003)(99286004)(6246003)(26005)(476003)(106356001)(74316002)(229853002)(97736004)(305945005)(53936002)(11346002)(446003)(5660300002)(14454004)(8936002)(52536014)(316002)(8676002)(81166006)(186003)(53546011)(14444005)(81156014)(93886005)(5024004)(3846002)(66574012)(33656002)(86362001)(44832011)(6116002)(68736007)(2906002)(7696005)(256004)(54906003)(586874002)(98474002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3656;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sh+xbhV2HFyVNgfITd1p9Cut0zF4qgVED6hOO9Gz+X8dYK6XoNwe5C5nZzFYN0/XTfhUfX2ZahTcahGSn+5WkryblKdZTkPwy2h19ReNxxKopJlO5BPjd0rZszBAeG0VgUho88amGMdHYBPSDJNU4tESuXgJiICOLI66nzCqlCpi9/WshSPKZpViY8qBYP12rKOETakBWbkitKSYPhAuI+bocNN7MQla34UuHmPh+vDFIMQjt2v7j6X9qdoyS+ExGWI51g40HlEMlf7nqez0gadzC5Q176wAEudPCOMmDawYOJ51E3fR7NyOLneNFMCiSpgL8BPoayP3w7/OiNA0kzIjto+g1CMM1Og/8oXxatcIfWLU8Sbx+jWn6RxF7PLP+fHoU1dq09UaT0BZwShGrqgJlPu8AeJSnKkAqoy2pVQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f4bb91-cb4c-489f-0117-08d6b406992c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 05:22:55.0213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
From: Matthew Wilcox <willy@infradead.org>
Sent: 26 March 2019 18:13
To: Pankaj Suryawanshi
Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
Subject: Re: [External] Re: Print map for total physical and virtual memory

On Tue, Mar 26, 2019 at 12:35:25PM +0000, Pankaj Suryawanshi wrote:
> From: Matthew Wilcox <willy@infradead.org>
> Sent: 26 March 2019 17:06
> To: Pankaj Suryawanshi
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
> Subject: [External] Re: Print map for total physical and virtual memory
>
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.

... you should probably use gmail or something.  Whatever broken email
system your employer provides makes it really hard for you to participate
in any meaningful way.

Okay i will use gmail.

> Can you please elaborate about tools/vm/page-types.c ?

cd tools/vm/
make
sudo ./page-types

If that doesn't do exactly what you need, you can use the source code to
make a program which does.

Thanks Matthew.
***************************************************************************=
***************************************************************************=
******* eInfochips Business Disclaimer: This e-mail message and all attachm=
ents transmitted with it are intended solely for the use of the addressee a=
nd may contain legally privileged and confidential information. If the read=
er of this message is not the intended recipient, or an employee or agent r=
esponsible for delivering this message to the intended recipient, you are h=
ereby notified that any dissemination, distribution, copying, or other use =
of this message or its attachments is strictly prohibited. If you have rece=
ived this message in error, please notify the sender immediately by replyin=
g to this message and please delete it from your computer. Any views expres=
sed in this message are those of the individual sender unless otherwise sta=
ted. Company has taken enough precautions to prevent the spread of viruses.=
 However the company accepts no liability for any damage caused by any viru=
s transmitted by this email. **********************************************=
***************************************************************************=
************************************
