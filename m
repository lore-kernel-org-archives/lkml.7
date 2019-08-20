Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FFFC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55B5214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="fAvpwIv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfHTNXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:23:31 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:58485 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728248AbfHTNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:23:31 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46CWhK379PzPk9r;
        Tue, 20 Aug 2019 15:23:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1566307409; bh=BxZImDV6BlbvPHA92gmLrkRnXj5dPxu62gW8SlF7G7o=;
        h=From:Subject:To:Cc:Date:From:To:CC:Subject;
        b=fAvpwIv/WZl+hu8gSJaP+zYQCU1KnTq8XWEnlWsEkloQ1mgSEUbBivjIbJYkRKkRu
         M4GFPD+PfGoF4O0zagcLg0v7ffqP+4MWkrKFW1RlKO/Lja3V5pGhv4w6h2t+QiZk9N
         3dZvZuBEpZJIgZzxSusj1m/rQ3gJ7jNKXWpde+AmKVwt9Qc+zXCb/VWvnlFmCMustY
         RwcCDg9hlzRLR7KA4CMuqYy4N+A9CcPXDQKWaYFEfK6w6eKdMEURwx4cskBANlu4IJ
         zUHfu+rU0qsJosfFOnO5X6XH1oMvLfj03ZdbL0uhsDHhE3pZE/OtAIq7/TymgnRe+B
         I057B2n63Rk/Q==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 109.41.192.99
Received: from [192.168.43.238] (ip-109-41-192-99.web.vodafone.de [109.41.192.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX198FXRVDZeSOd/yGZlSwh2MSmzQV7o2K6g=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46CWhG6N19zPjvd;
        Tue, 20 Aug 2019 15:23:26 +0200 (CEST)
From:   Sebastian Duda <sebastian.duda@fau.de>
Subject: Status of Subsystems - I2C/SMBUS ISMT DRIVER
To:     Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Message-ID: <97bcaca4-22f8-e17e-55b0-a19443c27bef@fau.de>
Date:   Tue, 20 Aug 2019 15:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Seth,
hello Neil,

in my master thesis, I'm using the association of subsystems to 
maintainers/reviewers and its status given in the MAINTAINERS file.
During the research I noticed that there are several subsystems without 
a status in the maintainers file. One of them is the subsystem 
`I2C/SMBUS ISMT DRIVER` where you're mentioned as reviewers.

Is it intended not to mention a status for your subsystems?
What is the current status of your subsystem?

Kind regards
Sebastian Duda
