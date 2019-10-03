Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5108C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA50222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQzhlNI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfJCHil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:38:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfJCHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:38:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so971978wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=ZM83gOZXBzuKBPm+cpBADT50KzkbNlmHyWH4vyQovk4=;
        b=UQzhlNI95Rym1id7Fj11KXbhswjhng4OESyiZubeTTkhvIjnlZqXXnNzAZMr+gbKmH
         zMpLuG5HOGiOvyH2b+ipaCoFhLvLushCE8jzLdB4Wgfphd+mDtIBzyIq5E9PwxYmnMd0
         +F5cdOzxlalBki7or97eQ4zro9J5gpspm6DW20F1eEJs7IcrRqgxq3+46RHLvD7IwQZJ
         8XG1oVUyncQZL2VJJctkTmWYOsQ7Rw7RWML0c4+AHjcMFP9qLv/ssh86pbGkr7TFGkEx
         Lc40b/11bARHVsPkIE7/pCWQ5+KVNxN80An5JZ9XTYcIHN7fnfZG+FuXKPyOA9VIXHgC
         xO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZM83gOZXBzuKBPm+cpBADT50KzkbNlmHyWH4vyQovk4=;
        b=hdw72/Ujct8G9TNvfddR3PfCNlD3gZ2BP0ILG6KX+/suk4HeKsdqI3QYx533fuW+uS
         3JHAXXxiabSSMC1B4QVb3hSdRlwbVZI5MIoFqcC8Z0uVgWo9+/VMK8yTZcXa36TSnfS4
         W+asylvRTCuh4gFk/ljTDloh2++rlP/pSR91iW6LdX3Arj7UUgXgpZCoBm/u2Zc3cuq7
         F6CA0xkDIjndadNL4y4hAQ1clx59E+L4GcrxgLt0J/qnA50DdRwP275tp3tTGXek2P13
         2KMtlIjn3lQDn9PcpH1jh4csS6wQHA8OxMGaiHMy2KoncmdYQqXa6B0svXpm7FsqAS9C
         uJLA==
X-Gm-Message-State: APjAAAXNWkmA1t8TW+gTlb6c0jA98ykvjB6rOOqf6J6ZkEgBg1aNCAY1
        75z9xtZH6ay2qSLVfSh8I3pIRgPnZFS05yHT6uLFfysepIs=
X-Google-Smtp-Source: APXvYqxuAzyywXV+QPlEJW7NYosSLHEFZ91NpQBpcBDY2xrxvYCk5/I57822uMeik6rUXKo4hgxHd5r6Yth91kApIVo=
X-Received: by 2002:adf:f092:: with SMTP id n18mr6065076wro.262.1570088319505;
 Thu, 03 Oct 2019 00:38:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 3 Oct 2019 09:38:27 +0200
Message-ID: <CA+icZUW9wrOAtEEXUNjHetq238D86c9c_Cf0iKQGiD+CH5bJrg@mail.gmail.com>
Subject: [Linux-5.3.y] Versions in stable.git and stable-rc.git
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I see two commits with "Linux 5.3.2" - in [1] it is tagged but there
is a second one in [2] - both in stable.git.

In stable-rc.git I see a commit "Linux 5.3.4-rc1" and there was no
v5.3.3 released before.

Can you look at this?

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.3.y&id=b09339127155bf38eb28bf8ef4781a53b4c1f13f
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.3.y&id=9c30694424ee15cc30a23f92a913d5322b9e5bd2
[3] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.3.y&id=11340e406e61338f7585324b65b1126503547bea
