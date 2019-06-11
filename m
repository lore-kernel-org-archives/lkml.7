Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE851C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8827921721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Y27SOox5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404831AbfFKQkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:40:12 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:39793
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388531AbfFKQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqoINAHvWhuMJ7IcYNQ1pzujMCi9HKTuXGVzKIm0Epg=;
 b=Y27SOox56yUaUx+7aolfCR4zpGjWjcpA+sWw4EGHjX1NxgYIyanC0MPRFsRVT8ph+mZf0HyXOMTaSbLI8Qpu3kG58VJ3y5lycmg2hnA2VBEzpXt8jOgzbcAB8tHqW9tkeD/sFchnic/P9USGdkJAhn2m7ENEpVLd+8R8rA6Rsjo=
Received: from VI1PR0601CA0039.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::49) by AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Tue, 11 Jun
 2019 16:40:08 +0000
Received: from VE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::200) by VI1PR0601CA0039.outlook.office365.com
 (2603:10a6:800:1e::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14 via Frontend
 Transport; Tue, 11 Jun 2019 16:40:07 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT004.mail.protection.outlook.com (10.152.12.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Tue, 11 Jun 2019 16:40:07 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 18:40:06 +0200
Received: from harkonnen.localnet (62.203.14.162) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 18:40:05 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, Pat Riehecky <riehecky@fnal.gov>,
        Alessandro Rubini <rubini@gnudd.com>
Subject: Re: [PATCH] fmc: Delete the FMC subsystem
Date:   Tue, 11 Jun 2019 18:40:05 +0200
Message-ID: <4878106.TDPaGnYU28@harkonnen>
Organization: CERN
In-Reply-To: <20190610141809.17542-1-linus.walleij@linaro.org>
References: <20190610141809.17542-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [62.203.14.162]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(956004)(70586007)(336012)(33716001)(186003)(486006)(426003)(476003)(53546011)(9576002)(16526019)(11346002)(446003)(9686003)(6306002)(229853002)(126002)(5660300002)(356004)(230700001)(26005)(36916002)(14444005)(6916009)(66066001)(23726003)(70206006)(76176011)(47776003)(6116002)(3846002)(44832011)(2906002)(106002)(6246003)(4326008)(54906003)(966005)(316002)(97756001)(305945005)(7636002)(7736002)(86362001)(246002)(478600001)(46406003)(8936002)(8676002)(74482002)(50466002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0602MB3749;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc5b6f5e-4ed1-486e-8d45-08d6ee8b76a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:AM6PR0602MB3749;
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3749:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <AM6PR0602MB3749BAEB193A414628483783EFED0@AM6PR0602MB3749.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ioq/WZJOT56m28XGrG5fBhbAABunzeIlVeYONSDln2d5jEYPuYCrfIncvwgRefNv672CNeYwS1FrA+O+Nuj9yyTx47pvdkDKDT+b/vmyZvAkkJr/mo0mZFJCP1rAy0DEUMV/18lJU7EHpDWmbadrUcyl07qruKJwmQmSlpU4wxpTcLWimH/5wmO/z+CyEi6zUhaZ14zeo4tUkKug8UTy874eclowljAPQ88WwdVcSL2YC+aVgagQ+oW1cRL3B2SyLUaCNqsBE18lJYZDQxj9AwWAoUvZnhAs/petE1TwGbpB2dmj+EDwSqznEEvK5LpYvc4fS4mh0VqKT8vRZmsSK5MVkE0gAl4W7Kf6nExC7Dwy8STOXzpNwmD8YDSmo3oi6rR7LYmKYUAFgERJZSW4GiHOp3tVH0gfTYolMGp/PsI=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 16:40:07.5423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5b6f5e-4ed1-486e-8d45-08d6ee8b76a6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well I do not know if it make sense to make it stronger with:

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

As you want

On Monday, June 10, 2019 4:18:09 PM CEST Linus Walleij wrote:
> The FMC subsystem was created in 2012 with the ambition to
> drive development of drivers for this hardware upstream.
> 
> The current implementation has architectural flaws and would
> need to be revamped using real hardware to something that can
> reuse existing kernel abstractions in the subsystems for e.g.
> I2C, FPGA and GPIO.
> 
> We have concluded that for the mainline kernel it will be
> better to delete the subsystem and start over with a clean
> slate when/if an active maintainer steps up.
> 
> For details see:
> https://lkml.org/lkml/2018/10/29/534
> 
> Suggested-by: Federico Vaga <federico.vaga@cern.ch>
> Cc: Federico Vaga <federico.vaga@cern.ch>
> Cc: Pat Riehecky <riehecky@fnal.gov>
> Cc: Alessandro Rubini <rubini@gnudd.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> If people are happy with this, I will queue the removal
> in the GPIO kernel tree.
> ---
>  Documentation/fmc/API.txt              |  47 ---
>  Documentation/fmc/FMC-and-SDB.txt      |  88 ------
>  Documentation/fmc/carrier.txt          | 311 --------------------
>  Documentation/fmc/fmc-chardev.txt      |  64 ----
>  Documentation/fmc/fmc-fakedev.txt      |  36 ---
>  Documentation/fmc/fmc-trivial.txt      |  17 --
>  Documentation/fmc/fmc-write-eeprom.txt |  98 -------
>  Documentation/fmc/identifiers.txt      | 168 -----------
>  Documentation/fmc/mezzanine.txt        | 123 --------
>  Documentation/fmc/parameters.txt       |  56 ----
>  drivers/fmc/Kconfig                    |  51 ----
>  drivers/fmc/Makefile                   |  15 -
>  drivers/fmc/fmc-chardev.c              | 200 -------------
>  drivers/fmc/fmc-core.c                 | 389 -------------------------
>  drivers/fmc/fmc-debug.c                | 173 -----------
>  drivers/fmc/fmc-dump.c                 |  59 ----
>  drivers/fmc/fmc-fakedev.c              | 355 ----------------------
>  drivers/fmc/fmc-match.c                | 114 --------
>  drivers/fmc/fmc-private.h              |   9 -
>  drivers/fmc/fmc-sdb.c                  | 220 --------------
>  drivers/fmc/fmc-trivial.c              | 102 -------
>  drivers/fmc/fmc-write-eeprom.c         | 176 -----------
>  drivers/fmc/fru-parse.c                |  81 -----
>  include/linux/fmc-sdb.h                |  39 ---
>  include/linux/fmc.h                    | 272 -----------------
>  25 files changed, 3263 deletions(-)
>  delete mode 100644 Documentation/fmc/API.txt
>  delete mode 100644 Documentation/fmc/FMC-and-SDB.txt
>  delete mode 100644 Documentation/fmc/carrier.txt
>  delete mode 100644 Documentation/fmc/fmc-chardev.txt
>  delete mode 100644 Documentation/fmc/fmc-fakedev.txt
>  delete mode 100644 Documentation/fmc/fmc-trivial.txt
>  delete mode 100644 Documentation/fmc/fmc-write-eeprom.txt
>  delete mode 100644 Documentation/fmc/identifiers.txt
>  delete mode 100644 Documentation/fmc/mezzanine.txt
>  delete mode 100644 Documentation/fmc/parameters.txt
>  delete mode 100644 drivers/fmc/Kconfig
>  delete mode 100644 drivers/fmc/Makefile
>  delete mode 100644 drivers/fmc/fmc-chardev.c
>  delete mode 100644 drivers/fmc/fmc-core.c
>  delete mode 100644 drivers/fmc/fmc-debug.c
>  delete mode 100644 drivers/fmc/fmc-dump.c
>  delete mode 100644 drivers/fmc/fmc-fakedev.c
>  delete mode 100644 drivers/fmc/fmc-match.c
>  delete mode 100644 drivers/fmc/fmc-private.h
>  delete mode 100644 drivers/fmc/fmc-sdb.c
>  delete mode 100644 drivers/fmc/fmc-trivial.c
>  delete mode 100644 drivers/fmc/fmc-write-eeprom.c
>  delete mode 100644 drivers/fmc/fru-parse.c
>  delete mode 100644 include/linux/fmc-sdb.h
>  delete mode 100644 include/linux/fmc.h
> 
> diff --git a/Documentation/fmc/API.txt b/Documentation/fmc/API.txt
> deleted file mode 100644
> index 06b06b92c794..000000000000
> diff --git a/Documentation/fmc/FMC-and-SDB.txt
> b/Documentation/fmc/FMC-and-SDB.txt deleted file mode 100644
> index fa14e0b24521..000000000000
> diff --git a/Documentation/fmc/carrier.txt b/Documentation/fmc/carrier.txt
> deleted file mode 100644
> index 5e4f1dd3e98b..000000000000
> diff --git a/Documentation/fmc/fmc-chardev.txt
> b/Documentation/fmc/fmc-chardev.txt deleted file mode 100644
> index d9ccb278e597..000000000000
> diff --git a/Documentation/fmc/fmc-fakedev.txt
> b/Documentation/fmc/fmc-fakedev.txt deleted file mode 100644
> index e85b74a4ae30..000000000000
> diff --git a/Documentation/fmc/fmc-trivial.txt
> b/Documentation/fmc/fmc-trivial.txt deleted file mode 100644
> index d1910bc67159..000000000000
> diff --git a/Documentation/fmc/fmc-write-eeprom.txt
> b/Documentation/fmc/fmc-write-eeprom.txt deleted file mode 100644
> index e0a9712156aa..000000000000
> diff --git a/Documentation/fmc/identifiers.txt
> b/Documentation/fmc/identifiers.txt deleted file mode 100644
> index 3bb577ff0d52..000000000000
> diff --git a/Documentation/fmc/mezzanine.txt
> b/Documentation/fmc/mezzanine.txt deleted file mode 100644
> index 87910dbfc91e..000000000000
> diff --git a/Documentation/fmc/parameters.txt
> b/Documentation/fmc/parameters.txt deleted file mode 100644
> index 59edf088e3a4..000000000000
> diff --git a/drivers/fmc/Kconfig b/drivers/fmc/Kconfig
> deleted file mode 100644
> index 3a75f4256d08..000000000000
> diff --git a/drivers/fmc/Makefile b/drivers/fmc/Makefile
> deleted file mode 100644
> index e3da6192cf39..000000000000
> diff --git a/drivers/fmc/fmc-chardev.c b/drivers/fmc/fmc-chardev.c
> deleted file mode 100644
> index 5ecf4090a610..000000000000
> diff --git a/drivers/fmc/fmc-core.c b/drivers/fmc/fmc-core.c
> deleted file mode 100644
> index bbcb505d1522..000000000000
> diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
> deleted file mode 100644
> index 32930722770c..000000000000
> diff --git a/drivers/fmc/fmc-dump.c b/drivers/fmc/fmc-dump.c
> deleted file mode 100644
> index cd1df475b254..000000000000
> diff --git a/drivers/fmc/fmc-fakedev.c b/drivers/fmc/fmc-fakedev.c
> deleted file mode 100644
> index 941d0930969a..000000000000
> diff --git a/drivers/fmc/fmc-match.c b/drivers/fmc/fmc-match.c
> deleted file mode 100644
> index a0956d1f7550..000000000000
> diff --git a/drivers/fmc/fmc-private.h b/drivers/fmc/fmc-private.h
> deleted file mode 100644
> index 1e5136643bdc..000000000000
> diff --git a/drivers/fmc/fmc-sdb.c b/drivers/fmc/fmc-sdb.c
> deleted file mode 100644
> index d0e65b86dc22..000000000000
> diff --git a/drivers/fmc/fmc-trivial.c b/drivers/fmc/fmc-trivial.c
> deleted file mode 100644
> index b99dbc7ee203..000000000000
> diff --git a/drivers/fmc/fmc-write-eeprom.c b/drivers/fmc/fmc-write-eeprom.c
> deleted file mode 100644
> index 3eb81bb1f1fc..000000000000
> diff --git a/drivers/fmc/fru-parse.c b/drivers/fmc/fru-parse.c
> deleted file mode 100644
> index eb21480d399f..000000000000
> diff --git a/include/linux/fmc-sdb.h b/include/linux/fmc-sdb.h
> deleted file mode 100644
> index bec899f0867c..000000000000
> diff --git a/include/linux/fmc.h b/include/linux/fmc.h
> deleted file mode 100644
> index f0d482d29df7..000000000000


-- 
Federico Vaga [CERN BE-CO-HT]


