Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfCSQan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:30:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42732 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:30:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so1383776pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8nnejzbaMmTvdcrG4k+TdjLblgZ1H17843Qm9AZxlM4=;
        b=GpIy94XIYwSyb+DvpxlQXb/6J0jAFT+99v2MbOQ3pLvbG6t0CyrNw/U+Q11J7Q/OdW
         S6Ih+fzA+oknnqI9/jcRb1c8gfKCJWqGi++FjW8vuSH3x1fMrKOWw87pixcFpwpGUwOz
         zn1/sAVQrN7RHOXInENCn+osOFndzabUDmDfRXLa3eeL2KzCggXLkkCMNzhAQmelBlvj
         /0nxKhuAtqzlb3XoZdzY7Yz2b8iUkdAD3dm0R1Qd0uib9b20Jh6fWeoJ0TFzPl9kdc95
         i0RBbCkI0AGE8+o+cIyw7AY8On0zsdFgI0lhwkczKdbxL+45Pta6LOipvtkE4PI/Ewel
         B93Q==
X-Gm-Message-State: APjAAAWbHvo1YSOFwwq71CNcV43rZxucXfclFJ4wl1TBJDQj4juzCi+h
        1JtCRrXtUwdiW2PEnnFtwbM=
X-Google-Smtp-Source: APXvYqwjQ2oW8txCgAqzNJ92ipImJqzqQY7HmjPArO22fJszu7WDBGWlV6DraNhrzyNYq7p9jzzdAw==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr3003709pfo.181.1553013042456;
        Tue, 19 Mar 2019 09:30:42 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u4sm10185113pgp.59.2019.03.19.09.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:30:41 -0700 (PDT)
Message-ID: <1553013040.152266.49.camel@acm.org>
Subject: Re: [PATCH v2 01/19] locking/lockdep: Change all print_*() return
 type to void
From:   Bart Van Assche <bvanassche@acm.org>
To:     Joe Perches <joe@perches.com>, Yuyang Du <duyuyang@gmail.com>,
        peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:30:40 -0700
In-Reply-To: <494746a793619dd9b43fb152de811a6e7de77cce.camel@perches.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-2-duyuyang@gmail.com>
         <494746a793619dd9b43fb152de811a6e7de77cce.camel@perches.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 02:45 -0700, Joe Perches wrote:
+AD4 +AD4 -static void
+AD4 +AD4 -print+AF8-circular+AF8-lock+AF8-scenario(struct held+AF8-lock +ACo-src,
+AD4 +AD4 -			     struct held+AF8-lock +ACo-tgt,
+AD4 +AD4 -			     struct lock+AF8-list +ACo-prt)
+AD4 +AD4 +-static void print+AF8-circular+AF8-lock+AF8-scenario(struct held+AF8-lock +ACo-src,
+AD4 +AD4 +-					 struct held+AF8-lock +ACo-tgt,
+AD4 +AD4 +-					 struct lock+AF8-list +ACo-prt)
+AD4 
+AD4 trivia:
+AD4 
+AD4 This style change seems superfluous as many
+AD4 other existing functions use the previous style.

I share Joe's opinion. 

Bart.
