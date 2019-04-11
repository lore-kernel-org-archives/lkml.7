Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1672133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="V+tDxMm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKNFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:05:25 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:40834
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbfDKNFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAa6UGTfbHb4W2+Tu1eL4fCw5lGBcBeHbNdhQaeDg7U=;
 b=V+tDxMm0XLNfX2COYptDldKLj1l1by220rJx4zhMlzC4Yy7oshwUb4dHR++6Tu8x5M+8exa8LgnAC5+7oLOoPnTH9TVtElbXDzNbBABAwjhfAK0B1XvStQ+PT62fKSR9+LZbhckdg38VIVmmRquT8s2Y5HNCk9yP2q/uGdA6518=
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com (10.170.247.12) by
 HE1PR07MB1034.eurprd07.prod.outlook.com (10.162.27.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Thu, 11 Apr 2019 13:05:21 +0000
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6]) by HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::cd23:d96f:5d94:cee6%7]) with mapi id 15.20.1792.007; Thu, 11 Apr 2019
 13:05:21 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: Add NULL TTY driver
Thread-Topic: [PATCH] tty: Add NULL TTY driver
Thread-Index: AQHU8GcqXTQLfjbFSk+VcCO84+l+yw==
Date:   Thu, 11 Apr 2019 13:05:20 +0000
Message-ID: <20190411130458.GA11390@localhost.localdomain>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
 <20190405090043.vnsftwpdm56cx2hr@axis.com>
 <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
In-Reply-To: <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0017.eurprd03.prod.outlook.com
 (2603:10a6:3:76::27) To HE1PR07MB3337.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78775249-c1ad-4ad3-a180-08d6be7e5a29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB1034;
x-ms-traffictypediagnostic: HE1PR07MB1034:
x-microsoft-antispam-prvs: <HE1PR07MB10342DC00BAC24FFD9633F48EF2F0@HE1PR07MB1034.eurprd07.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(486006)(86362001)(76176011)(305945005)(7736002)(4326008)(33656002)(26005)(6486002)(2906002)(102836004)(81166006)(25786009)(6506007)(52116002)(14454004)(53546011)(99286004)(71190400001)(9686003)(81156014)(6512007)(5660300002)(478600001)(53936002)(386003)(71200400001)(6436002)(68736007)(1076003)(8676002)(256004)(6916009)(93886005)(54906003)(97736004)(106356001)(186003)(446003)(61506002)(6116002)(66066001)(105586002)(229853002)(8936002)(11346002)(3846002)(476003)(6246003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB1034;H:HE1PR07MB3337.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E2yKP3VeThYUOeTHN8YoVPBTtWepQQNcoJ+Dq2DWdSWf0UB4Gl67uYkICnfQ+FK112O2oIeDyLWjqmU28W5AqWUzKFHNu8w1k4DKeRj8ow0iH07l48VTjRTb3AFKQo6bWp6IwGHxUIGMC9VB3+5L492Mw+PvyBpJybWqDnf/oD4Nfug2zL0NTq5PPyLEx7ZvZiBYCP22gTrirE/xd3lhnQxoYrKcW89LOC2YWMLmj0Eu8+HCj1xvwvInv8HvZJVaR1kyhqT/Kpu48VQN/fbwej55m3cYJhNFfJmWujqU7H7gA4Re6RQiuNboTi11dkl2OAnXAjkYtWgF4Q1E6vIVcw4KOuPSXxr7pfZpNJh8SAVxXetSgeJ+3jEGvyyXb3WQRVLWWmTdwCxvGeLxGhjm3EgcTm8pBevVz9jbPv4QMv0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C43D4ACF1EE1649BC9EA1DECB6883F1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78775249-c1ad-4ad3-a180-08d6be7e5a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 13:05:21.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 02:32:41PM +0200, Enrico Weigelt, metux IT consult =
wrote:
>On 05.04.19 11:00, Vincent Whitchurch wrote:
>> On Fri, Apr 05, 2019 at 10:39:43AM +0200, Enrico Weigelt, metux IT consu=
lt wrote:
>>> On 03.04.19 16:11, Vincent Whitchurch wrote:
>>>
>>>> Especially on embedded systems, it would be convenient to have a simpl=
e
>>>> way to disable the console (both for kernel and userspace) on a system
>>>> which normally uses it, to free up the UART for other things.
>>>
>>> Just symlinking to /dev/null does not work ?
>>
>> No, /dev/null does not support the TTY ioctls.
>
>hmm, wo (which programs) do you need, that really need them ?
>
>>> OTOH, if you're introducing a dummy console, wouldn't a ringbuffer that=
,
>>> can be read out later, a better option ?
>>
>> There is already a ttyprintk driver in mainline to send these messages
>> to the printk ring buffer if one is actually intrested in what is
>> written to the console.  There's no option to enable it via console=3D i=
n
>> mainline but I have a patch for that too.
>
>Great. IMHO, that would be the better way.

There are (embedded) cases where the kernel ring buffer is stored for
log inspection and all the logs that are *not* wanted there (like
interactive debug logs, some progress bar, etc) are send specifically to
/dev/console to avoid sending them to normal log store (as they are only
useful when debugging over console). In non-debug mode /dev/console
becomes /dev/null to speed things up.

I would personally benefit from Vincents patch. In fact I found this
thread because I was considering doing exactly the same for our system.

Krzysztof
