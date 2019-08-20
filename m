Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B9CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917E422DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="huDQZX3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbfHTOBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:01:11 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:53959 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729409AbfHTOBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:01:11 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46CXWn33YLz8sjs;
        Tue, 20 Aug 2019 16:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1566309669; bh=SmuOtpO6yuKYH+j3hML+tD9JcY//jbVASvT2tW8jJg0=;
        h=To:Cc:From:Subject:Date:From:To:CC:Subject;
        b=huDQZX3X2ooKpF87PkijbUnni6fbU/AH3fPB28C7wQJZJCGQ3cYtkCmH2DpRmqdle
         KClmdVDnuoSkLpVJwpVU89HPKCQKvckGzlfA4aABoe+/4nDVC2vdPgWhROv6Nhihc1
         +RSbghZ+3Ft9icFfe1kAXPVmPUaTOH5dp2FOFGtLc9ZM/ocW76V4/8yuACgPtxTYTV
         us/ZiSJpjtejJWGW3R4vJ4hNoRjoz1m+hOXLb29jXsnKxN0/WAN4CvEh+Xysca/6qY
         KXHaopKqSxDdCDzWW/LU6Y/HdTHdvETPWEF06uqqzYR/vlSilcS/Q1wsMYiQH7IXG1
         h6O8E7GJ/eJqw==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 109.41.192.99
Received: from [192.168.43.238] (ip-109-41-192-99.web.vodafone.de [109.41.192.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18bHEwurg2pUjyR/ultBHm/eqbxfTc8GUY=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46CXWY2RPGz8sdL;
        Tue, 20 Aug 2019 16:00:57 +0200 (CEST)
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
From:   Sebastian Duda <sebastian.duda@fau.de>
Subject: Status of Subsystems - TI BQ27XXX POWER SUPPLY DRIVER
Message-ID: <92d7646f-5a53-95db-d179-45a95c621c43@fau.de>
Date:   Tue, 20 Aug 2019 16:00:56 +0200
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

Hello Andrew,

in my master thesis, I'm using the association of subsystems to 
maintainers/reviewers and its status given in the MAINTAINERS file.
During the research I noticed that there are several subsystems without 
a status in the maintainers file. One of them is the subsystem `TI 
BQ27XXX POWER SUPPLY DRIVER` where you're mentioned as reviewer.

Is it intended not to mention a status for your subsystems?
What is the current status of your subsystem?

Kind regards
Sebastian Duda
