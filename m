Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57BEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FE0206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfISKAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:00:55 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:33569 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388998AbfISKAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:00:54 -0400
X-ASG-Debug-ID: 1568887252-0a88186e233c0c130001-xx1T2L
Received: from zotac.vandijck-laurijssen.be (77.109.114.181.adsl.dyn.edpnet.net [77.109.114.181]) by relay-b03.edpnet.be with ESMTP id yHRd4Vdt3K9Beyu4 for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 12:00:52 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Apparent-Source-IP: 77.109.114.181
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 015239DD623
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 12:00:51 +0200 (CEST)
Date:   Thu, 19 Sep 2019 12:00:50 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-kernel@vger.kernel.org
Subject: Re: Question on priorities with CAN
Message-ID: <20190919100050.GC1446@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: Question on priorities with CAN
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20190919084053.GB1446@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919084053.GB1446@x1.vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Start-Time: 1568887252
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 19
X-Barracuda-Bayes: SPAM GLOBAL 0.9322 1.0000 3.5743
X-Barracuda-Spam-Score: 3.57
X-Barracuda-Spam-Status: No, SCORE=3.57 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76589
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, wrong list
