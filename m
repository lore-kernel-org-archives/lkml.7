Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ECBC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AD206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZDJ2fJwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFEGRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:17:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFEGRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8MOKfPDZiHvrtm5mx7wXDojKN0NUKE9GkL6OvbIkYfk=; b=ZDJ2fJwcq5zM4+WFIIwMSc+Wl
        AhQTcFyhKkrl5ssuEyrnkRfSEBF8uBP2s+h6UP3vC/zDbUJYGZ48NKk2MWLe1J8B9+WiGJXCRdhhX
        Aq3nagWNZWdFHIJqlemTN3Mbq7/gkTM6uUfAAdva3O3iB5zunDic/JjH8VIx1UKWw/N89OVIIGWNB
        1I6XTw3upAWMD1ggLV9QYQk6Kj7tZpESseTLUwBNP5qzIH9V1dlX/pOX26PCzHCf8qBwgPJhzhLAU
        8MTHiJjzG5oU9bvAfFDYKdgd8MS9e1S1+AgKu/WWPA3E0ZFoXUHP1ffweEMWRFob1cbz9FXrMHgrg
        3uTxt/oQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYPF6-0007g4-AF; Wed, 05 Jun 2019 06:17:48 +0000
Date:   Tue, 4 Jun 2019 23:17:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 0/6] sched: Add new tracepoints required for EAS
 testing
Message-ID: <20190605061748.GA20661@infradead.org>
References: <20190604111459.2862-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patches add the bare minimum tracepoints required to perform EAS
> testing in Lisa[1].

What is EAS?  Whhy is "Lisa" not part of the patch submission?
submission.

> It is done in this way because adding new TRACE_EVENTS() is no longer accepted
> AFAIU.

Huh?  We keep adding trace events all the time.  And they actually
are useful because they are testable.

This series on the other hand adds exports not used in tree, which is
a big no-go.
