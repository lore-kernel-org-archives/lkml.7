Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA5C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 04:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B927320867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 04:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jDBzaRzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfJGEo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 00:44:56 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:21826 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGEoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 00:44:55 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x974ilEW020257
        for <linux-kernel@vger.kernel.org>; Mon, 7 Oct 2019 13:44:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x974ilEW020257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570423488;
        bh=nm9jLCqW2dM+1/6xMbp2kR3LZ2AfAGLbbyVwSCuBwro=;
        h=From:Date:Subject:To:Cc:From;
        b=jDBzaRzOna3FvCKBTAu/zdteatFeH8zo1x1AXDAHonON1l8LvbFxkw5ketXACTdxu
         Jk0of4QFVQp0pkl/tzx31GFdX8IXsWY7cF8GdFckH3njH0Cg1tyMH2q6YNq6K0tbCG
         keKuJksQVhDjMIEobydIg3f6BNc2uDIIeGD8YDQC9BBacGWT7CUGKV1y4eM7wG9FCt
         GtEY7gpoXWtwUekczyM+676iQsXeW+3oF/wgJYboMQJXefgBsJiphuojZgGcYqoNmy
         Izcz67J5q6nzWCG1AeR5aMpyq/jI7lW2Bfm5wSkCjlwmM4TdQVsXL0gtxhAiwJZeTH
         03V/+hnBUJveA==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id p189so2661601vkf.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 21:44:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUg1rWVYbjQDVGk2tz8fN4CXTmYBBDm57c6FeabkPyubUH3WdQj
        T+bMPAXUKTS9bQqPER8+ozKcyv1Cc4FaEkqO92A=
X-Google-Smtp-Source: APXvYqwbRNoEj6rk8oMCyzNcW3lDlp8GMskfG4ex0fBzv6iLXQaZ59RJH7/l6cubaxTFc19mYyBxpqARrdoeLPaDav0=
X-Received: by 2002:a1f:5f51:: with SMTP id t78mr13580171vkb.66.1570423486450;
 Sun, 06 Oct 2019 21:44:46 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 7 Oct 2019 13:44:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKUAoHDFzGJ3snAy2XeQshTqmzDMUC7qqU8=L-p=+LNg@mail.gmail.com>
Message-ID: <CAK7LNARKUAoHDFzGJ3snAy2XeQshTqmzDMUC7qqU8=L-p=+LNg@mail.gmail.com>
Subject: checkpatch: false positive "does MAINTAINERS need updating?" warning
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,


I ran checkpatch.pl against the following:
https://lore.kernel.org/patchwork/patch/1136334/


I did update MAINTAINERS, but I still get
"does MAINTAINERS need updating?" warning.
Why?



$ scripts/checkpatch.pl
0001-doc-move-namespaces.rst-out-of-kbuild-directory.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#18:
 Documentation/{kbuild => admin-guide}/namespaces.rst | 0

total: 0 errors, 1 warnings, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-doc-move-namespaces.rst-out-of-kbuild-directory.patch has style
problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


-- 
Best Regards
Masahiro Yamada
