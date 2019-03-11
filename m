Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7333206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="Qz6v2Thh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfCKPRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:17:38 -0400
Received: from mail-eopbgr1320057.outbound.protection.outlook.com ([40.107.132.57]:43453
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfCKPRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-com0iei;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMkdK3u1xljTRK3M7FRBn2rdcWSFVZmp2/FVpyveSLo=;
 b=Qz6v2Thhgogx3237fEvg7alul3qP6/w71sdzIHqoByvwSkX0IoYCSLUd5hWu4NdPB9hKq8MLzopE7eYDGFWi5pAFcDkPQBTlKA5Oz6ZER0jV72tNh+mt0IQA3xTeEqw4tRjbaZUGVWmYlm1pBqqJZAA2dj3D9w4ASt9m/nI8hOs=
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com (20.177.148.141)
 by HK0PR01MB2100.apcprd01.prod.exchangelabs.com (52.133.159.20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.21; Mon, 11 Mar
 2019 15:17:33 +0000
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::7050:232d:ebc2:bb8e]) by HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::7050:232d:ebc2:bb8e%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 15:17:33 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Successfully Setup Azure Active Directory Synchronization with Office
 365 for Business
Thread-Topic: Successfully Setup Azure Active Directory Synchronization with
 Office 365 for Business
Thread-Index: AdTYHYD37lt/RyFSTY2y2WV5394bgg==
Date:   Mon, 11 Mar 2019 15:17:33 +0000
Message-ID: <HK0PR01MB2644304F0C1C2C448B889BEE87480@HK0PR01MB2644.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6006e1c1-1a36-4986-cc9d-08d6a634afa8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7027125)(7031125)(7035125)(7023125)(7093024)(5600127)(711020)(4605104)(2017052603328)(7153060)(7177060)(7172020)(7174020)(7193020);SRVR:HK0PR01MB2100;
x-ms-traffictypediagnostic: HK0PR01MB2100:
x-ms-exchange-purlcount: 12
x-microsoft-antispam-prvs: <HK0PR01MB2100B0D95F8BD7825E5EC5E887480@HK0PR01MB2100.apcprd01.prod.exchangelabs.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(34036004)(396003)(39830400003)(376002)(346002)(366004)(47610400004)(448600002)(189003)(199004)(52536013)(5660300002)(476003)(105586002)(486006)(5640700003)(68736007)(86362001)(97736004)(38610400001)(586005)(52230400001)(6436002)(6916009)(99286004)(7696005)(107886003)(26005)(33656002)(6506007)(66066001)(74316002)(6116002)(45080400002)(3846002)(186003)(8936002)(106356001)(4326008)(2351001)(2501003)(7736002)(305945005)(25786009)(256004)(71200400001)(53936002)(71190400001)(14454004)(2906002)(6306002)(81156014)(966005)(8676002)(81166006)(9686003)(55016002)(102836004)(102460200001);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR01MB2100;H:HK0PR01MB2644.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HK0PR01MB2100;23:7/AFzcXhtUZmSnvidNwjECnO8tUsfUR8BtyUDAD?=
 =?iso-8859-1?Q?TwTsTn/FSjTVNbWsNebD9V8A+rm3Psy0BTx3a+SCYzSlC05B7sF3tuZMsY?=
 =?iso-8859-1?Q?bIoCnRAx+eynoVwOhKv0OK5PB9YfCHrXgGJRrMB8DVk2VowVdpuOZMljTr?=
 =?iso-8859-1?Q?ocn2fxrtGeBraf0pCiX5v6JljBRaQgDyW7wbvyaBarCn9b5z5YTTbYdzJH?=
 =?iso-8859-1?Q?ucOEY4+UUowP9yx0M7ezbqc3PCjYFfL83KhLfMwpYWToQl0y95O18NY8SI?=
 =?iso-8859-1?Q?b84vT5QzIQ82F05eS+loS3e+DlwFt2Z+J+ys3DnvA++5iXgtS+ylFqtUwL?=
 =?iso-8859-1?Q?QJHlc3Ahw34vrpCPgc497tPDP2HvBpM21C2QMK3Yx+Rrfyv+gKQQG90uru?=
 =?iso-8859-1?Q?cO+VPgJehI68hAfq2664foYdXdWI82p4qVNe5UIG+MVmL0PbrHO+labS4S?=
 =?iso-8859-1?Q?VXsNFZiDNMQyQvmwBqufzmK31EiSPWCA7iL249AJ9W7C6BhNSreFQlmnJN?=
 =?iso-8859-1?Q?z6uSPclHLof6KlfOQHBgI6z2u79qkKjHreovQTiGO10lBerKd/mCYtyErT?=
 =?iso-8859-1?Q?OdJfnG+2RE5fK1zMt8NZELxLVoP3NGDbij/Kj3xhbDuz4XHwcBuriDWOQK?=
 =?iso-8859-1?Q?5XHXP6dZWIlelMPfmWREJmPWPtaNeJ4R0OK2zXwJGrV3ECirlw18Jnt7wp?=
 =?iso-8859-1?Q?yw3Ph6xBFKjarBr2QOk3ZVfY8cTw73QyExEu2jB9Ckc6tKvw3/pyq6vE2q?=
 =?iso-8859-1?Q?ss+FLEASxZbtRDTKNaA/XkHb7n7AbMbct8yt2wVKVTF1aoJrhhDSvkVfK8?=
 =?iso-8859-1?Q?8cbvaafPYWBuDzcIMDWFJR0o/6i3YErUWgyRBYoJtoX9wQVMDeTI+D5yO2?=
 =?iso-8859-1?Q?7FgRz465hFWAZuRRJIHO5pn/DZZh2MbR3ZAeVih/k0bpusi8HXewZB48tV?=
 =?iso-8859-1?Q?jSWrxrpMYatPcXVebPzQDFH5sYBHJWHNfTy0+6uuY56HdiczdSr/dnhPSS?=
 =?iso-8859-1?Q?bG0kmFDGI85rT8Ajs2/v6VDx4xxgnAYUZOeQXoJnZmm0Vt0F64rSzn+5yU?=
 =?iso-8859-1?Q?HApilSvNPhikyJCklSa9FmqRXxoqXW0VzvxWNBZffcVZf+3YLUv3QOK3o7?=
 =?iso-8859-1?Q?AMWIjcdd9mR8zNRjB04CnROcLlPcy7lACPqD+qdGL6SOfFAqj9xc7Kvu5E?=
 =?iso-8859-1?Q?+tw9mn28sIKiq/jBP0GQgBb3wrDXTLIHZm+Yp9FpRSW1TYulx/CAB0wXK0?=
 =?iso-8859-1?Q?jdxdKoSi0z00Bn4V44q434BxcbLpXzN5Ai1glSMAXv+e0rPTg+dWBDSzp3?=
 =?iso-8859-1?Q?WCXx0Og2+ac24EpaABQaRmwMCZ5UVhCbKOva5wZAp0WCPQduSWsXAsJKjn?=
 =?iso-8859-1?Q?jZePfC4nskdBQxKxpKoPVGTKaFT6k9uStdnjv/jomO0xkhaBT2w=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 13eBpTBBUHWZmypAlPSA5WIVXrh0tMzwCMDQ7nITAhVJ3K7VGZINvvLVcCuBtxSZsiqGgE+2091k6OydHVY9cuUR9sIhVTocvyVn4+DwiWm7HyLoBy1xIFZwL1m1ajrSRuWEaRR0BaVsOc/B1TkWMsrmu+CHZcq7xCTQpPRqP7nyAgPc2lVqzP2qimO0fMB1+bBdqLUhC03Fnuy3nYR4OaKldVJvbxYI8iJASLLy5vy6fdTwwr//gepRNNYCO2FNL8k8i42T0OGoa0tB8oe3kPuz2mH7mfu8W1lgA1yidmLZu3XP5FFJaDsLAdGTZBH2Ggcq28LYow6cJxbrIrpAFiDgt6DsM8Pfl9siCk2WVtoxSTGiNT4Ea5LDwTdPWehCWRNYfmLGC8ibyuuRpv+fXPh5A3ond9ZlXFS+2wBtSdQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6006e1c1-1a36-4986-cc9d-08d6a634afa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 15:17:33.4859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject/topic: Successfully Setup Azure Active Directory Synchronization wi=
th Office 365 for Business

Good evening from Singapore,

If you receive this email from CEO@teo-en-ming-corp.com, it means that Mr. =
Turritopsis Dohrnii Teo En Ming in Singapore has successfully setup Azure A=
ctive Directory Synchronization with Office 365 for Business at about 2:00 =
AM Singapore Time on 10th March 2019 Sunday.

The following is a list of official Microsoft documents and manuals which I=
 have followed.

[Step 1] Set up directory synchronization for Office 365

Link: https://docs.microsoft.com/en-us/office365/enterprise/set-up-director=
y-synchronization

[Step 2] Prerequisites for Azure AD Connect

Link: https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to=
-connect-install-prerequisites

[Step 3] Azure AD Connect and Azure AD Connect Health installation roadmap

Link: https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to=
-connect-install-roadmap

[Step 4] Getting started with Azure AD Connect using express settings

Link: https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to=
-connect-install-express

[Step 5] Add your custom domain name using the Azure Active Directory porta=
l

Link: https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/=
add-custom-domain

[Step 6] Assign licenses to users in Office 365 for business

Link: https://docs.microsoft.com/en-us/office365/admin/subscriptions-and-bi=
lling/assign-licenses-to-users?view=3Do365-worldwide

[Step 7] Create DNS records at any DNS hosting provider for Office 365

Link: https://docs.microsoft.com/en-us/office365/admin/get-help-with-domain=
s/create-dns-records-at-any-dns-hosting-provider?view=3Do365-worldwide

[Step 8] Gather the information you need to create Office 365 DNS records

Link: https://docs.microsoft.com/en-us/office365/admin/get-help-with-domain=
s/information-for-dns-records?view=3Do365-worldwide

Thank you very much.

=3D=3D=3DBEGIN EMAIL SIGNATURE=3D=3D=3D

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of U.S. Em=
bassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic Qualifications a=
s at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

=3D=3D=3DEND EMAIL SIGNATURE=3D=3D=3D

