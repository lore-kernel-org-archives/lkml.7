Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B43C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D57A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfIQSzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:55:55 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45654 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfIQSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:55:55 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CF7063C04C0;
        Tue, 17 Sep 2019 20:55:52 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vqZ65qPc6gsS; Tue, 17 Sep 2019 20:55:46 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id C7D7D3C00C4;
        Tue, 17 Sep 2019 20:55:46 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 20:55:46 +0200
Date:   Tue, 17 Sep 2019 20:55:46 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     shuah <shuah@kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/2] selftests: watchdog: Validate optional file argument
Message-ID: <20190917185546.GC16818@vmlxhi-102.adit-jv.com>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190916120816.GA30453@vmlxhi-102.adit-jv.com>
 <f07c0dac-4d01-f661-25ea-9d077e96e9e7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f07c0dac-4d01-f661-25ea-9d077e96e9e7@kernel.org>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(For LKML readability) Superseded by:
 - https://patchwork.kernel.org/patch/11149287/
   ("[v3,1/2] selftests: watchdog: Validate optional file argument")

-- 
Best Regards,
Eugeniu.
