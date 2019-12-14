Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185F8C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E256C20724
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfLNShO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:37:14 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39285 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 13:37:14 -0500
Received: by mail-pl1-f175.google.com with SMTP id z3so1118513plk.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 10:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fDi3go+cgZ7zREiYSpSvMocBbyGj4IXfMH2dwOtb9AA=;
        b=ukK7i+xT9XhkZibAF5yOXUPUepPofcWmGx3hY4JEe2ZUFwnr3hFSJoX5b3a1ZViFJ9
         o6rhqhH44X+3DVicWwAoDVFSTklSo0KszR+Xig8DhlnmYypVtWZvx9B/4cEMzi/esqV0
         MYY5BKDi+5tR//RwmUL+DSrYuNRwahwVsGsuG8E6JtkEa3pgjmQDqOtYkwFOr9x0qaQk
         hLhZn2E2xDAu5JisvCUba1jYPSdlank+KOt1AZJU3ARv/Vpz9QeILM+jZ0iQmYxj3Mxg
         6VwYXW7TfPs5qzkfGj5y4tJZKYslhW/QHgmhx/XLmM8+Qa44zL4c6PAyCGgRk9fGnzNh
         jBkQ==
X-Gm-Message-State: APjAAAVHWKnNik8nW8ZNJDSCTXcU9rGkuQibK+3WdTaVwNXobDB73W3c
        f3r7RBJEWglrASqvz5+q9HnyS/rE
X-Google-Smtp-Source: APXvYqyU9447ekZDZwnwKPDDDrIhIveEE3o7Y8eb6vojEL2DbjwJPP1Y7c5l29p3DboZGuujbuGZLw==
X-Received: by 2002:a17:902:9a8d:: with SMTP id w13mr6446493plp.330.1576348633372;
        Sat, 14 Dec 2019 10:37:13 -0800 (PST)
Received: from [10.234.191.77] ([73.93.155.125])
        by smtp.gmail.com with ESMTPSA id m12sm15170555pgr.87.2019.12.14.10.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2019 10:37:12 -0800 (PST)
Subject: Re: [PATCH] locking/lockdep: Fix lockdep_stats indentation problem
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org
References: <20191211213139.29934-1-longman@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bca1ba05-fc5a-e31b-57fa-3ba2e070fb84@acm.org>
Date:   Sat, 14 Dec 2019 10:37:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211213139.29934-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 4:31 PM, Waiman Long wrote:
> It was found that two lines in the output of /proc/lockdep_stats have
> indentation problem:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
