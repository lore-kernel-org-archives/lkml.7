Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F77C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452CF2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLPTCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:02:39 -0500
Received: from namei.org ([65.99.196.166]:37828 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfLPTCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:02:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xBGJ295Y009899;
        Mon, 16 Dec 2019 19:02:09 GMT
Date:   Tue, 17 Dec 2019 06:02:09 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
cc:     gregkh@linuxfoundation.org, rafael@kernel.org, dhowells@redhat.com,
        matthewgarrett@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] debugfs: Return -EPERM when locked down
In-Reply-To: <20191207161603.35907-1-eric.snowberg@oracle.com>
Message-ID: <alpine.LRH.2.21.1912170601440.7457@namei.org>
References: <20191207161603.35907-1-eric.snowberg@oracle.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2019, Eric Snowberg wrote:

> When lockdown is enabled, debugfs_is_locked_down returns 1. It will then
> trigger the following:


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

