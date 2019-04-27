Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF1C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF5C20684
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS7b9Aoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfD0Dhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:37:36 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38519 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfD0Dhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:37:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id a13so1980567ybm.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FD3GzSzV6kfngOTtNkMi5HaAYykizHDGxwY3wl8eOtI=;
        b=BS7b9Aoo5xGz63UXi+8KBpSKLEwn/54RMIYS4J2/6GfJMH7qNF5tCB/vDhGH9bWL4f
         np1xiLa2P+0dgslPQjHJXA+t/S7ZpoTNUk2muc/H63noP+NFV3Ta4CeBFwD13n14Gr8G
         YYyDAJVhCpHqclvQjekyYnghwaNv1wz37Wrk6mB1s4Z+AePQhKWG4MY/YcmYKY8VVWFO
         iOacHYoONQwlUQq8uhF0uY8tPkjJOV4zmjsP5T6kr6HhjQCao659saxwNPsFK1eL4ZkW
         iohRoMvv7vWAwhWPfANILd7oBdzN5wXg/zCHuthbIpTRugXUIsM9izibkZL8+0ZqMEQY
         zM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FD3GzSzV6kfngOTtNkMi5HaAYykizHDGxwY3wl8eOtI=;
        b=RVop5OjFFbu3wHW1wA0kIqnb9RN9Rd3tZkbYoJvzkUdtAEitLpn7LjltqTZFA+E//C
         N8c5W9ichOn2PEblfAZcn2nini1BULU35yjdt8/2lLUqlLdK2WshM1MfqpjhJcvqrOTh
         WLER0KURXTOEy/rRUP9Y+kjJR/oEgGCINYfgBWywcQb7CTPOqRxPHe8GDv3iriIS1bsA
         1yporoNDO7exexrdGBXzAmMKVhgTbY4onINwkWtSMHF51EmKpP2S6leRLTo+n9I1y6qR
         u8ALv1JMRp5bAVb93O7KrgY8VMJ/gs2Cw81jLDROAhHj0Fzv3Z1/ApVhXpt5X0p0l4Tb
         SWaQ==
X-Gm-Message-State: APjAAAXfJW7Xb2BjCcKXWLEyd4aS7IWe4XcpHsaCdcORtaABB9j7rXul
        4fbF95HpfAx7MdcVc/iqIKGgDAzyOQcP4BSDCfJpFLc=
X-Google-Smtp-Source: APXvYqyU7+dDGgJEtz9qp0t4wX7bq4puKCBxsQxSyxeiSUEg35WO69GFvDjLKKBpaIQW+s2KEhhrR36nQfjDt9VgCEM=
X-Received: by 2002:a25:ac68:: with SMTP id r40mr1309470ybd.357.1556336255169;
 Fri, 26 Apr 2019 20:37:35 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Sat, 27 Apr 2019 11:37:22 +0800
Message-ID: <CANnei0HoniCup8sHzTDx_4AyWfxRNP9NFbRmCCLcUyCSQec5zw@mail.gmail.com>
Subject: Suggestion to the 100,000 Unemployed Persons in Singapore
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject/Topic: Suggestion to the 100,000 Unemployed Persons in Singapore

For Immediate World-Wide Release 26th April 2019 Singapore Time

I would like to suggest the 100,000 unemployed persons in Singapore to
apply for refugee status in developed countries outside of Singapore.

I believe many or most of the 100,000 unemployed persons in Singapore
are TARGETED INDIVIDUALS (TIs).

-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
