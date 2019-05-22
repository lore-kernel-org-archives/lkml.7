Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C971C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47550217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfEVCsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 22:48:54 -0400
Received: from namei.org ([65.99.196.166]:33706 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfEVCsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:48:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4M2mnNd006699;
        Wed, 22 May 2019 02:48:49 GMT
Date:   Wed, 22 May 2019 12:48:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] Add the ability to lock down access to the running
 kernel image
In-Reply-To: <20190521224013.3782-3-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1905221246040.3967@namei.org>
References: <20190521224013.3782-1-matthewgarrett@google.com> <20190521224013.3782-3-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Matthew Garrett wrote:

> +	int (*locked_down)(const char *where, enum lockdown_level level);

> +static int lockdown_is_locked_down(const char *what, enum lockdown_level level)

I'm guessing 'what' is the best option here.


-- 
James Morris
<jmorris@namei.org>

