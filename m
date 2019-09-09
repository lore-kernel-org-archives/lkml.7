Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,URIBL_DBL_SPAM,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE867C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FBF20678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ystp.ac.ir header.i=@ystp.ac.ir header.b="HA3WbcRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfIIXED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 19:04:03 -0400
Received: from ms3.ystp.ac.ir ([78.39.159.15]:42384 "EHLO ms3.ystp.ac.ir"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbfIIXEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 19:04:02 -0400
X-Greylist: delayed 10208 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 19:04:02 EDT
Received: from localhost (localhost [127.0.0.1])
        by ms3.ystp.ac.ir (Postfix) with ESMTP id 1B7DBA28782;
        Tue, 10 Sep 2019 00:13:11 +0430 (+0430)
Received: from ms3.ystp.ac.ir ([127.0.0.1])
        by localhost (ms3.ystp.ac.ir [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PHQnXab1LkFt; Tue, 10 Sep 2019 00:13:10 +0430 (+0430)
Received: from localhost (localhost [127.0.0.1])
        by ms3.ystp.ac.ir (Postfix) with ESMTP id 5CDF1A2879A;
        Tue, 10 Sep 2019 00:13:10 +0430 (+0430)
DKIM-Filter: OpenDKIM Filter v2.10.3 ms3.ystp.ac.ir 5CDF1A2879A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ystp.ac.ir;
        s=52244776-9648-11E6-8E52-D9F3D0CA04A5; t=1568058190;
        bh=wPuP1NSjZjUlSu/QMiHkBCTxaZoX8lhWinmOQDpvWHM=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=HA3WbcRhMFbGmbV7En5mpYUHZwQ3NHCURGAOTB+uyMkXiJURtmfxyNpNbQDkdwRA+
         6wekgy6ZBHDCccQGWwx07jMb67Vv1bNBiXA+AYAepQxo2yjxoEDnipcNkbhv8RuHf4
         q/1d8KI7wSYJyfahwCxg87t+BR3Sh+VdHDf3CefM=
X-Virus-Scanned: amavisd-new at ms3.ystp.ac.ir
Received: from ms3.ystp.ac.ir ([127.0.0.1])
        by localhost (ms3.ystp.ac.ir [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5HlmT_yIZvdr; Tue, 10 Sep 2019 00:13:10 +0430 (+0430)
Received: from mail.ystp.ac.ir (unknown [176.12.161.66])
        by ms3.ystp.ac.ir (Postfix) with ESMTPSA id DA214A28785;
        Tue, 10 Sep 2019 00:13:04 +0430 (+0430)
To:     "sweet and hot" <sweet_and_hot@pantiesparadise.de>,
        "utf 8 B WmRlbsSbayBQb2zDoWNo" <zdenek@kaora.cz>,
        "linux kernel" <linux-kernel@vger.kernel.org>,
        "jepar" <jepar@hush.com>, "tdr" <tdr@hush.ai>,
        "chickabomb" <chickabomb@pantiesparadise.de>,
        "casting" <casting@spermafreunde.de>,
        "hobbyhure" <hobbyhure@melideluxe.tv>,
        "berndweber68" <berndweber68@yahoo.de>
From:   Bernd Weber <shookuhi@ystp.ac.ir>
Subject: =?UTF-8?Q?Fw=3A=F0=9F=94=93Na._wie_geht_es_?= =?UTF-8?Q?dir=3F?=
Message-ID: <65e6e689-259e-4a7b-b111-27174e7c0ab8@ystp.ac.ir>
Date:   Mon, 9 Sep 2019 11:38:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Das ist unvorstellbar! http://dvcvhksp.Sefton158.xyz/index


___
Wiederschauen
Bernd Weber
