Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C863A208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF1Aah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:30:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41379 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1Aah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:30:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so2174914pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BWNCp5oDedqi8XCpspBk7yeVq6vT3KAfD7C5KenC1qs=;
        b=bmPn2eezvZw065SCLtl52Sd5/W2T24ygMVwU6CRMOznBnXc3TI7kECSwteLXeue6OQ
         xhUVkibhoMWCmuj6SVWqiJgvZMPrmxBz8chBj7Rqts1vp1CQkfET2BQobUKGRUidfGsp
         xABqfn6+THiM6kyYWIEX3zjmaadqoOLUNQvjKKLsZNepu0jytJhcZhaVLgeeYX+13J44
         I/bjvGSA8iwS4trFVYqGQvgkfU37QN4h8iE8vkD7d8N0VwdQq0atgSBmkvoIRFWuyqik
         xRebg/om7fMV+UKJWDo+BpWYGfSWJCNThEIXbQdVsApi9L4Xtw4DRxdT88mtnpoC5Dnm
         3aEw==
X-Gm-Message-State: APjAAAXByZJFK3Z0tYPs/QOZIEfBMiJIeJabpwF5fF88LyHMtk0oShNP
        0SD2kfI5e1kVWIZHVsknzcNJ20x6HM4s7g==
X-Google-Smtp-Source: APXvYqwSsoGpP6vuymQafT37ejUikDhjErlrchUK2E+9rL7N1nLO439uXvDYCVQ6Kz0TGkJekr5sCA==
X-Received: by 2002:a17:902:7448:: with SMTP id e8mr3430303plt.222.1561681836058;
        Thu, 27 Jun 2019 17:30:36 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id u16sm350793pjb.2.2019.06.27.17.30.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:30:35 -0700 (PDT)
Date:   Thu, 27 Jun 2019 17:30:35 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 17:30:19 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: change the arch/riscv git tree to the new shared tree
In-Reply-To: <20190627090116.GB23838@infradead.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-45bbc7fa-7b3e-4893-8a09-5e7449673254@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 02:01:16 PDT (-0700), Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 12:25:18AM -0700, Christoph Hellwig wrote:
>> On Thu, Jun 13, 2019 at 12:07:21AM -0700, Paul Walmsley wrote:
>> > Palmer, with Konstantin's gracious help, set up a shared kernel.org
>> > git tree for arch/riscv patches going forward.  Change the MAINTAINERS
>> > file accordingly.
>> >
>> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>> > Cc: Palmer Dabbelt <palmer@sifive.com>
>>
>> Should you be added to the maintainers?  Is Albert still around, as
>> I see a lot of people Ccing him, but never getting an answer?
>
> ping?

Odd.  I significantly remember saying "let me just finish writing this patch
before we have lunch" at the last day of the workshop, but it looks like I
never sent it out and can't find the actual patch.  I'm blaming this new
laptop, which is constantly blowing up on me :)
