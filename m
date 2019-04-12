Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52B0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4AE2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="XLudiNQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDLHeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:34:07 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com ([40.107.4.122]:29326
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfDLHeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD1LfUiJtpL2TMk54OQm7Ow6cs8LoNgR/eo4zJRTwYY=;
 b=XLudiNQ6hX+23i2skPAOcz8gaKIBaDYZxYSgnr6gp+g5NkLk828WuX6RATiATGPdL7Z8tzU55kTpH3JWHxHiTPheIdfK7CsKXbFHfLVgSgHfzBgnt0QjuXhPWUkTUKmgoeN6aZCmm5E8mlHNRT99pRI+q8OX9/W4T1KUtLtP0Nw=
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com (10.170.247.12) by
 HE1PR07MB3371.eurprd07.prod.outlook.com (10.170.247.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.11; Fri, 12 Apr 2019 07:34:03 +0000
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6]) by HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6%7]) with mapi id 15.20.1792.007; Fri, 12 Apr 2019
 07:34:03 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: Add NULL TTY driver
Thread-Topic: [PATCH] tty: Add NULL TTY driver
Thread-Index: AQHU8GcuXTQLfjbFSk+VcCO84+l+y6Y4HsMAgAAEjAA=
Date:   Fri, 12 Apr 2019 07:34:02 +0000
Message-ID: <20190412073344.GA28707@localhost.localdomain>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
 <20190405090043.vnsftwpdm56cx2hr@axis.com>
 <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
 <20190411130458.GA11390@localhost.localdomain>
 <c77474fd-96d6-392b-9a54-fd7e6a29b72d@metux.net>
In-Reply-To: <c77474fd-96d6-392b-9a54-fd7e6a29b72d@metux.net>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0098.eurprd02.prod.outlook.com
 (2603:10a6:7:29::27) To HE1PR07MB3337.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d3ce99a-ee58-433a-998b-08d6bf193c2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB3371;
x-ms-traffictypediagnostic: HE1PR07MB3371:
x-microsoft-antispam-prvs: <HE1PR07MB337152C89510B000E50CF380EF280@HE1PR07MB3371.eurprd07.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(39860400002)(376002)(189003)(199004)(305945005)(68736007)(2906002)(71190400001)(105586002)(14454004)(486006)(71200400001)(93886005)(6436002)(33656002)(186003)(1076003)(106356001)(97736004)(256004)(3846002)(6116002)(86362001)(478600001)(6486002)(6506007)(81166006)(61506002)(81156014)(8676002)(76176011)(102836004)(4326008)(229853002)(66066001)(25786009)(6916009)(386003)(5660300002)(316002)(9686003)(54906003)(52116002)(7736002)(6512007)(99286004)(8936002)(53936002)(446003)(11346002)(476003)(6246003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3371;H:HE1PR07MB3337.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JcRxbqQaPYECXRehiOtffPx3+gxAXgkgPAD797J/FlFqDxhKup64FB2gybBQlFI7UPUPEACvF71gie1idxvtVRUAv7cuh55jvaK0oJacEUT4vCu3djHkNKfPAMpZlz2TxYV1YhIbzNvisaQreZsVFirhVWSS85QwK7o3uQE3DiE4NiRHP60BoTY0k8QUOjNW0oRW4OCso9YF4RQZU0bgL7sVAZWBgZiJNdabvK50raoW7EN1XDvxCfsgbFPeg2VBgIzsCM5fOGcbfXIWS8bXx9UsTYHVUpo6Rly/Rdyzns/jsau5H6C06v6v22B9SgvZ6E51fxiFudQq15WWRJjw2MidEn1eMnlIntOSQEI7ir8OsV7HrexvkI6gy4iu5P/zbou4OWn13oJYhTTgFEu/pJ3P7nGZWMT/0zNODQW6kiU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A893B4885CB3E44BD0C3EFD48679150@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3ce99a-ee58-433a-998b-08d6bf193c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 07:34:02.9855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 09:17:28AM +0200, Enrico Weigelt, metux IT consult =
wrote:
>On 11.04.19 15:05, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
>
>> There are (embedded) cases where the kernel ring buffer is stored for> l=
og inspection and all the logs that are *not* wanted there (like>
>interactive debug logs, some progress bar, etc) are send specifically
>to> /dev/console to avoid sending them to normal log store (as they are
>only> useful when debugging over console). In non-debug mode
>/dev/console> becomes /dev/null to speed things up.
>So, in your case, it doesn't need to be an actual tty, any file/chardev
>already do it, correct ? But then, why is that new driver needed ?
>

Well, that depends. If the program doing those writes expects /dev/console
to be a tty device, then it cannot be any file. But, yes, there are usually
other ways of achieving this goal that do not involve adding kernel driver
but none of them is as convenient as having this kernel support. With this,
we can only switch kernel cmdline without any modifications to the rootfs.
The discussed kernel driver is very simple so there is little effort requir=
ed
for this convenience. Maintaining it would be very easy and, of course,
anybody not needing it, can simply disable it in config so there is no cost=
.

Krzysztof
