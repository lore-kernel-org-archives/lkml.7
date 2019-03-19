Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC8F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCSPcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:32:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfCSPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:32:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 777C7AFF0;
        Tue, 19 Mar 2019 15:32:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Mar 2019 16:32:45 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] fs/epoll: remove an unnecessary argument of
 ep_busy_loop()
In-Reply-To: <20190308081420.18719-1-rocking@whu.edu.cn>
References: <20190308081420.18719-1-rocking@whu.edu.cn>
Message-ID: <0f9b082b663fd9988436cec2196efb11@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-08 09:14, Peng Wang wrote:
> When ep_busy_loop() is called, timed_out is always zero,
> otherwise ep_poll() would return first.

Yes, that's correct.

Reviewed-by: Roman Penyaev <rpenyaev@suse.de>

