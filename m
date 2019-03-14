Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED64C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB9C2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCNHJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:09:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37111 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCNHJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:09:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id x10so1562995wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Aj8OTmPajxdr27wOgArDDDfg/uUox4NIQcMNv5EFKE=;
        b=lOAbiJD+A+FFMvXYyHej3CCM6KUYS8opzJUxJVXhoPIDwe+WtzD7cRxgdzOJ285W6p
         Qm2070KYjYNfuO1kXDMr8boHd/R/dyV5KUAlQTgyKnykPSAmbnAowfYgjXSiwesLCk3j
         VDI3YDZ3vZGlcE0bxgWouiHUwzcn5hDNn77uw2Eg1UkPcYet2OTM1C4B14e/K5x8rJmo
         3Fbvhlyn5JKdWAlU4rQd2U8fQ76XO6Wc090ILfuXfRLCtu9V8ANaxo4R7SrGPA2n2sPS
         +pdJEdLfsozdfw3Q/69KUJoHUDbaOirebDMMVqM+U03RPLGsWgX8usO+R7pAC2P+hnNB
         2CXg==
X-Gm-Message-State: APjAAAVH1tPbO8IYCkDaiRBAwjvj7yf8bPt7GP9TD3DTLhPAg9qy6y6w
        dTj0SG68ZApYPUDeEBnthVCvpw==
X-Google-Smtp-Source: APXvYqxOLmKj5LtZcgBOUMsbw3gBuw3a3gM9rIzmxPpbcRf+KU+rOwlBuiDFxGWGy9eTyxO52zop3A==
X-Received: by 2002:a1c:c00a:: with SMTP id q10mr1385168wmf.90.1552547394884;
        Thu, 14 Mar 2019 00:09:54 -0700 (PDT)
Received: from localhost.localdomain ([151.15.240.16])
        by smtp.gmail.com with ESMTPSA id h10sm2789890wmf.2.2019.03.14.00.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 00:09:54 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:09:51 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com
Subject: Re: [RFC PATCH RT] x86/tsc: Add option to disable tsc clocksource
 watchdog
Message-ID: <20190314070951.GC31405@localhost.localdomain>
References: <20190307120913.13168-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307120913.13168-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/03/19 13:09, Juri Lelli wrote:
> Clocksource watchdog has been found responsible for generating latency
> spikes (in the 10-20 us range) when woken up to check for TSC stability.
> 
> Add an option to disable it at boot.

Gentle ping.

Does this make any sense?

Thanks,

- Juri
