Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA1AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3C1218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfCOSW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:22:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34604 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfCOSW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:22:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id n6so6073901qkf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 11:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=c3rlewspvBx4mFf+c2GnzCnBBrTGkVE0TbuZDNPQe4Q=;
        b=Ggw3CyOXEWu1BJ1BFjsaXQvzUwo6yJjM/nvZ+zmZzuIosUNxGQYFGiJoDIMEdvvevy
         QFIm8vP+6Ti7tGXbxn7dqcpeh8KnqzggZitfm8EhwKVyI22QPCArWbvcyYB9UbA8OoIw
         N8/DP9f8xOZvwoXye4+a4YmU8cq+6b5eEcPQAHOPX0e2+kdCmc6HUuLOU8BgFQHhdqfR
         2c65zIL8qbrX/d0heDtzuzG7vn5YvhdGBjNRt5DD5+NMWEoC94wThkbf/p54kZL9zdsK
         9u14gYdTDaHKfImfGrtsaxjH3N4sV2vXnRUtfbQ7n48drbYXYtPiYJjKY+0Z7HZWvL2l
         aHTg==
X-Gm-Message-State: APjAAAWbO8pPxT3fdr9bBSN4WDULaQs2cWJEpGRF2p0vg5gKWx0nAET0
        go9l3OfQrR8RDymv2NIQZQPbluUb4sM=
X-Google-Smtp-Source: APXvYqyQvEerUS2JN9kCTfZ3KjvZyzlagIBgZ8Yovt/4PMqrh754294Pb/t4Rjcnlf6bJnQuhSDGcA==
X-Received: by 2002:a37:8b87:: with SMTP id n129mr3842567qkd.5.1552674176141;
        Fri, 15 Mar 2019 11:22:56 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::362? ([2601:602:9800:dae6::362])
        by smtp.gmail.com with ESMTPSA id u18sm1855352qka.25.2019.03.15.11.22.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 11:22:55 -0700 (PDT)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: Participation in Distro kernel microconference at Plumbers?
Message-ID: <d951ec7e-7ac1-5ad8-3172-91e8e451aa9f@redhat.com>
Date:   Fri, 15 Mar 2019 11:22:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on organizing a microconference for Linux Plumbers 2019
focused on distribution kernels. The focus is on collaboration on
common problems for maintaining and distributing a kernel for any
kind of distribution (embedded, enterprise, community, internal, extrnal).
Ideally, this would be a topic that could be presented and discussed in 20-30
minutes (we can be flexible depending on the number of topics though).

If you have something that might be a good fit for this, please
reach out to me off list. Feel free to pass this around to anyone
who might be interested.

Thanks,
Laura

