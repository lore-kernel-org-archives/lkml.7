Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8FCC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B125C204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfICVSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:18:02 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:50939 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbfICVSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:18:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B1FED100E86CC;
        Tue,  3 Sep 2019 21:17:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trade03_4529f89b0df58
X-Filterd-Recvd-Size: 1411
Received: from XPS-9350 (unknown [172.58.30.235])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Sep 2019 21:17:55 +0000 (UTC)
Message-ID: <7cd37b0130f9dcabc00721913b63cab222267a78.camel@perches.com>
Subject: Re: [PATCH] mailmap: Update email address for Quentin Perret
From:   Joe Perches <joe@perches.com>
To:     Will Deacon <will@kernel.org>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, qperret@qperret.net, corbet@lwn.net
Date:   Tue, 03 Sep 2019 14:17:25 -0700
In-Reply-To: <20190903145950.xko5fejupxj3f5nx@willie-the-truck>
References: <20190902105036.32419-1-quentin.perret@arm.com>
         <20190903145950.xko5fejupxj3f5nx@willie-the-truck>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 15:59 +0100, Will Deacon wrote:
> What's the best way
> for get_maintainer.pl to retrieve up-to-date contact details for developers
> who aren't in MAINTAINERS?

Updated .mailmap entries.


