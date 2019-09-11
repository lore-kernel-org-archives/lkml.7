Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB3C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DBF2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfIKRTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:19:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40580 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfIKRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:19:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id b80so14756214oii.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=lagNI/PLpM9uenHkNSBRNWBaN+S5ImPbZCfrPAVgyoZodXY0XMilI8a7f1SDUFI/Xu
         dSrjpK8H7cVk70GXik62BjDsXIxxII1Eu8yTystx+oGk6id0WS9H6g5c3lPKXCMSVoMH
         ay6H9rjsvsFnLr/qJxufpBUHrAUDWQ4AGV7/HwzUGL7O/4T5t65fidgBv235l++qLo+l
         nWE6/fKIcpesO4kYLQNCkK0FpZA+NY3ouD35cygxf0Eqh7R1q90GET7sUOUlpBZfGNav
         wjagJn9lYUVbPjvd/GOv+4XslamgIMrt972wck5EQgZE1jrVyEJewovQYcyqzx0/bhkj
         0znQ==
X-Gm-Message-State: APjAAAVGW4DlxcuqcDexrKrZX/NO3AeA8KrwWXyMk6da5MovG1X8X1/T
        C9x1WBx7qbQF23r612mQ+Bw=
X-Google-Smtp-Source: APXvYqyXdUt23tgPQin40lxwUV+EKeatQGhs0ErHQZEAGbpfUnvyS+B+QJgGXG2sgbFG5xYLgOPwRQ==
X-Received: by 2002:aca:574c:: with SMTP id l73mr5397367oib.47.1568222353181;
        Wed, 11 Sep 2019 10:19:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id t18sm8721368otd.60.2019.09.11.10.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 10:19:12 -0700 (PDT)
Subject: Re: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     Gabriel C <nix.or.die@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <335f6d13-e61b-c683-6589-cc8b097a9e57@grimberg.me>
Date:   Wed, 11 Sep 2019 10:19:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
