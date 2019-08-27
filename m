Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955AEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB2B20656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfH0KK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:10:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62304 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfH0KK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:10:29 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7RAAQIJ089913;
        Tue, 27 Aug 2019 19:10:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 27 Aug 2019 19:10:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7RAALww089881
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 27 Aug 2019 19:10:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
To:     Michal Hocko <mhocko@kernel.org>, Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
References: <20190826193638.6638-1-echron@arista.com>
 <20190827071523.GR7538@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5768394f-1511-5b00-f715-c0c5446a2d2a@i-love.sakura.ne.jp>
Date:   Tue, 27 Aug 2019 19:10:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827071523.GR7538@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/27 16:15, Michal Hocko wrote:
> All that being said, I do not think this is something we want to merge
> without a really _strong_ usecase to back it.

Like the sender's domain "arista.com" suggests, some of information is
geared towards networking devices, and ability to report OOM information
in a way suitable for automatic recording/analyzing (e.g. without using
shell prompt, let alone manually typing SysRq commands) would be convenient
for unattended devices. We have only one OOM killer implementation and
format/data are hard-coded. If we can make OOM killer modular, Edward would
be able to use it.

