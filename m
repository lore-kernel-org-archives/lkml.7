Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E12DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD23213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uaslpedu.onmicrosoft.com header.i=@uaslpedu.onmicrosoft.com header.b="B00r3P2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCNCCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:02:48 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:35846
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfCNCCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uaslpedu.onmicrosoft.com; s=selector1-uaslpedu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkcRc+2i3Tf6jYzJEPFo8RaDNnBBsDNwv5NbOmj7yxQ=;
 b=B00r3P2nev6HbpVKH6yJiqKWBIvJr30icpBRHtUG8drW0FgsKdYbPp/6kqus6hpN0OkOS7VkynozpJpcUGnefZUrFjXClNqyqo4PCJsoKNkPgVDfJan6bgEZOU1rMVXT9VnMht+2jWtWXrW0Mkd9K0JXswbbs99yn2eaR+jAQHk=
Received: from BL0PR16MB2148.namprd16.prod.outlook.com (52.132.27.151) by
 BL0PR16MB2500.namprd16.prod.outlook.com (20.177.147.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 02:02:46 +0000
Received: from BL0PR16MB2148.namprd16.prod.outlook.com
 ([fe80::50d3:eacc:5120:a367]) by BL0PR16MB2148.namprd16.prod.outlook.com
 ([fe80::50d3:eacc:5120:a367%5]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 02:02:46 +0000
From:   LUIS EDUARDO CEPEDA CABRERA <A228663@alumnos.uaslp.mx>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE,
Thread-Topic: RE,
Thread-Index: AQHU2fd10GFd282LGEGSrydo6znFHA==
Date:   Wed, 13 Mar 2019 23:49:55 +0000
Message-ID: <BL0PR16MB214802BFCC7E4FBF309CC6B3994A0@BL0PR16MB2148.namprd16.prod.outlook.com>
Reply-To: "miz.sharifahahmadmustahfa@gmail.com" 
          <miz.sharifahahmadmustahfa@gmail.com>
Accept-Language: es-MX, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0205.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::29) To BL0PR16MB2148.namprd16.prod.outlook.com
 (2603:10b6:207:3e::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.80.131.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 559b50ba-4700-4d04-3925-08d6a80e980b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR16MB2500;
x-ms-traffictypediagnostic: BL0PR16MB2500:
x-microsoft-antispam-prvs: <BL0PR16MB2500BBA6734D382F43E0B70A994B0@BL0PR16MB2500.namprd16.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(476003)(43066004)(25786009)(478600001)(72206003)(14454004)(53346004)(169323002)(6666004)(71200400001)(4270600006)(256004)(486006)(99286004)(2860700004)(71190400001)(5003540100003)(68736007)(3480700005)(66806009)(5660300002)(74482002)(97736004)(2501003)(53936002)(86362001)(8676002)(7736002)(8936002)(74316002)(81156014)(7116003)(8796002)(9686003)(81166006)(5640700003)(305945005)(55016002)(558084003)(221173001)(66066001)(105586002)(786003)(106356001)(33656002)(2906002)(26005)(6346003)(186003)(6506007)(386003)(6916009)(3846002)(6116002)(2351001)(6436002)(102836004)(22416003)(7696005)(316002)(52116002)(52536014)(171493001)(231573002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR16MB2500;H:BL0PR16MB2148.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: alumnos.uaslp.mx does not
 designate permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=A228663@alumnos.uaslp.mx; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bYtIaabc9nkwoTxwaZhtKP5B22H1k5B8O9EUh0ISQnWGWzLU1C8USR6iICqd4dcmyePkYR0yCD+L0nYdcV8qOaqeCG07QTVbtFdhc/LiEK1zum/aP2DdNPqjaQIYwiIbj+8po+eEdIrPvYhyRBojNhmeHeQbe1LsImG8kft5lpfXbUruI/dztb/5sbiwGNCYr9weN+AoDH4WiasOdk8HhbyCu17N0NE2hFA1vxGnZzJK6Hozbea76ZXOOXNUp8qaiun69gz82340qHaB57q7Zo6iiQFRKwy0DKk4Uuf35CBNWfDHhS8cDH1cfAbJkGV1IK6Qwfd3Zr5tpglJp7BbZLiRwnF9ZD7E2YG59OjzcWfKuRRskTh6o7UBFMMq2J1l52ZgA+O12/W1aRhYBz3skev9vfiDc2Ibvg00XbC5KmU=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <524A3D1F432CD944957432C29EF76CD5@namprd16.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alumnos.uaslp.mx
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b50ba-4700-4d04-3925-08d6a80e980b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 23:49:55.5226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60681658-0f2d-4a4e-aaf1-6fd5f2dba33f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR16MB2500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 i have a deal for you, can we work together ?
