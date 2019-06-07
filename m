Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF640C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99110208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLHx4i9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbfFGTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:52:19 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:35193 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfFGTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:52:19 -0400
Received: by mail-it1-f172.google.com with SMTP id n189so4593844itd.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Vyf/WXCNzO2X4wtwg+6QhvUGv3EtzlO22nBwEXIhIIQ=;
        b=gLHx4i9Tum1PFG/FyvmU20c2bflVGdEqAeYc/RTWhORGtX0bTRnyCTohdToY1YKBdt
         UQp8ZpV5bAeIZ4aVtOu4YH5OtIFzMj1xGeZgVsK+D4xRuLezx16OPUpfNhXa565h9NQb
         PejMN0hfW2xSpfZrl9W1Ttb3WyZi7fPhmnLZ/1EeamQ9EnSHeL2BCLAnm26T5e+RMXMC
         CSuNy4h3shC4b41jqzT61ITHeXUz6Liru3rgPyDMCQdTDwYZe+Jfyg4E6aByVJWwH6y9
         wAy+8s+Qnae7dF1CJYH9cAji7ZgogWOo9JfwhreuVwyUpI0EXygWzp0zHf4WbBXabMGv
         NiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Vyf/WXCNzO2X4wtwg+6QhvUGv3EtzlO22nBwEXIhIIQ=;
        b=BjD2fA1TcWaYwQFB1bxUwlo8ndBMDOiOUAgmamyGOIEszvNBScRI2lo2BK6VKArSg8
         zhxThOJ2mTTRpgYLCCQNFQna5pRjBiyENEBXLLme3PU53Wp/I8aAG64yOkSj8S9TJ7xR
         D3kxM7VO2uPbUtbireu2ZNHdi3kjMDDHepM0nRzshGk7JiT4zkvjZ7letrVT1q1iAnpU
         pbEVvOl6YfUWY6pq4ZQUZe2vUNQPli8bOXTGylVRy6nQUzrmw2nN1K9HNfeSrEdA7yA1
         /nz5KizKlr09giOVJ/kT/EtFiKHG7csr0Aq2bcL3o+v7b6aJtdvloCfioylmtU49Gc0K
         N1pg==
X-Gm-Message-State: APjAAAX9CxH8HLdER200jK6RA4/XZjqb1pUL8w7M6ejc/9Gi53qn87kj
        y8OOjVMqo2uKbDBEPT6SuAkBVEFhkMbSBEsJiOAuuBfJrR/irg==
X-Google-Smtp-Source: APXvYqxLPqRiRP+rl8hwWOR/QgkwfLpwkyBBtYErRafVtVbsFNq3BpYce0TewyRI3AE6sDdjbL+kwfubmeDR/lenBtE=
X-Received: by 2002:a24:44e:: with SMTP id 75mr5635274itb.22.1559937138521;
 Fri, 07 Jun 2019 12:52:18 -0700 (PDT)
MIME-Version: 1.0
From:   Damian Tometzki <damian.tometzki@gmail.com>
Date:   Fri, 7 Jun 2019 21:52:02 +0200
Message-ID: <CAKUTLK81aj6CyDrv7Ppd_rh5H_3gOziYzFnT83-_g=4KcMEN5Q@mail.gmail.com>
Subject: tt
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tt
