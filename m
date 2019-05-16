Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00099C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5DC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="AYoK6XMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfEPBrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:47:03 -0400
Received: from mail-eopbgr700102.outbound.protection.outlook.com ([40.107.70.102]:17281
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbfEPAvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dje4x//trVncAnKm+qu2xqw1BCFnT5iTQIs+2qIRqM=;
 b=AYoK6XMeKjTzsBZGCAIQjyVJL1gQHikWe1gdTB0aCgzsnw7KGWehanGngYgYMMfb814tEZoNzPlDnjw5N9k/nrOrAI6KcJqRGJfcClFn8WBxdaZP3c0x25z4yTmiZ6CEDBERTsxy6RgO8vOI3nmc2WpIf5EU3EPYgcMwBl7QukM=
Received: from MN2PR13CA0033.namprd13.prod.outlook.com (2603:10b6:208:160::46)
 by DM6PR13MB3131.namprd13.prod.outlook.com (2603:10b6:5:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.11; Thu, 16 May
 2019 00:51:50 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MN2PR13CA0033.outlook.office365.com
 (2603:10b6:208:160::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.7 via Frontend
 Transport; Thu, 16 May 2019 00:51:49 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.228)
 smtp.mailfrom=sony.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Thu, 16 May 2019 00:51:43 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x4G0pggK011483;
        Thu, 16 May 2019 00:51:42 GMT
Received: from USCULXHUB05V.am.sony.com (usculxhub05v.am.sony.com [146.215.231.43])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x4G0pfAx000562;
        Thu, 16 May 2019 00:51:42 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0439.000; Wed,
 15 May 2019 20:51:41 -0400
From:   <Tim.Bird@sony.com>
To:     <sashal@kernel.org>, <tbird20d@gmail.com>
CC:     <vkabatov@redhat.com>, <dhaval.giani@gmail.com>,
        <alexander.levin@microsoft.com>, <shuah@kernel.org>,
        <khilman@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>, <dan.carpenter@oracle.com>,
        <willy@infradead.org>, <gustavo.padovan@collabora.co.uk>,
        <dvyukov@google.com>, <knut.omang@oracle.com>,
        <eslobodo@redhat.com>
Subject: RE: Linux Testing Microconference at LPC
Thread-Topic: Linux Testing Microconference at LPC
Thread-Index: AQHU/HOdrYJ31qGl6EuNFEVWpVDaoaZtSbqA//+/VjA=
Date:   Thu, 16 May 2019 00:51:37 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF9771A6DF@USCULXMSG01.am.sony.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
 <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
 <20190516003915.GT11972@sasha-vm>
In-Reply-To: <20190516003915.GT11972@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(448002)(45074003)(85644002)(189003)(13464003)(199004)(50466002)(46406003)(70586007)(70206006)(55016002)(229853002)(86152003)(97756001)(37786003)(4326008)(76176011)(2906002)(23726003)(86362001)(26005)(186003)(102836004)(85326001)(55846006)(7696005)(8936002)(8746002)(6246003)(7736002)(54906003)(110136005)(246002)(33656002)(72206003)(8676002)(66066001)(316002)(478600001)(4744005)(47776003)(486006)(126002)(476003)(2876002)(356004)(5660300002)(426003)(11346002)(3846002)(446003)(6666004)(6116002)(305945005)(336012)(7416002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR13MB3131;H:usculsndmail01v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail01.sonyusa.com,mail.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 005cb9c8-d625-412c-3ecd-08d6d998adca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR13MB3131;
X-MS-TrafficTypeDiagnostic: DM6PR13MB3131:
X-Microsoft-Antispam-PRVS: <DM6PR13MB3131E314B97E42C3C0C034B1FD0A0@DM6PR13MB3131.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: F+DwqkdalXklvbwD/GT3yyzsqN2itJ1c7TE5Dd8Ba96YkOE3HSyXPlVirsSfJRS6+5CJBhsdwjBeQuQVydHf501vlt8irQcLuXDKgUrNGQySjfe9VJ9q7z74Gh372kgTk68o4P3G2AVeTl0PCsW9zEBMVGH+G+qyl+3V+uoBIgfPAg2DkrMz4XfYsYfnQOS6t/yNBQgBesSaeHDq+L4ql9pX320k7agL4EY4+BzFoGGRXVVrQHmS9Aho9yk5UBng/dlFybN3Ru7u75xee21ffaCBXcZ2lZs6xl0KGtTwx3saboXL1Y8r4jRJCSk96YAbwz/jMQJbuZX/PxcOoffWERrN/qx7heY0dfraSq94mHyjzsibzH7OduwW0cME+zO5XqipLQg9Ej1mrNGZqSmq9uRAkInoTIXVGZVEEgd20Gg=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 00:51:43.9485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005cb9c8-d625-412c-3ecd-08d6d998adca
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sasha Levin=20
>=20
> On Fri, Apr 26, 2019 at 02:02:53PM -0700, Tim Bird wrote:
...
> >
> >With regards to the Testing microconference at Plumbers, I would like
> >to do a presentation on the current status of test standards and test
> >framework interoperability.  We recently had some good meetings
> >between the LAVA and Fuego people at Linaro Connect
> >on this topic.
>=20
> Hi Tim,
>=20
> Sorry for the delayed response, this mail got marked as read as a result
> of fat fingers :(
>=20
> I'd want to avoid having an 'overview' talk as part of the MC. We have
> quite a few discussion topics this year and in the spirit of LPC I'd
> prefer to avoid presentations.

OK.  Sounds good.

> Maybe it's more appropriate for the refereed track?
I'll consider submitting it there, but there's a certain "fun" aspect
to attending a conference that I don't have to prepare a talk for. :-)

Thanks for getting back to me.  I'm already registered for Plumbers,
so I'll see you there.
 -- Tim


