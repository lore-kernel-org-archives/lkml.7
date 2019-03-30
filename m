Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48535C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C10B2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFU+Y6P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfC3QNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:13:22 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44307 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfC3QNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:13:22 -0400
Received: by mail-wr1-f51.google.com with SMTP id y7so6264092wrn.11;
        Sat, 30 Mar 2019 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=D4t2OFTHRWIowRhfn68GI6Nt93T3e9VAQoVXgmwE3/U=;
        b=WFU+Y6P0zx9CyCIlrvwcVJp4gnWFLfyzStNvkfaSZvkcP4VgoxWYHFTAGW+dxjJS/3
         zR91Ys/TaroTXgl2vWXOEh77iasOTAQrD1imbvNTHNKJqBSadt3jaGpgQP1oDQoLHTPZ
         vXFOsMziOptBWi8CIqbbCxKJJii8Gw3gxH8NSpaXcz4j251v9lqlFAbwg8T+MCLs87HB
         aP/7gsC3iPQurJdkQ0aZxTIDwgvCDYRvaNzjhkQojpRjwEj401M9VEZ8cJYUqGmKA5mi
         hyAZzVOJT+vlTosgigqnub6nIlVhId15/MSGAl0n535azqXlL3hiftRQ4ivsVPJeg3kj
         0g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D4t2OFTHRWIowRhfn68GI6Nt93T3e9VAQoVXgmwE3/U=;
        b=Xey4IZhvaH+3ghtCPU1GpOGDGdFwzo4H2gIy1Q0UgmPeXFHIY0jEmQKO+3sshIsCZ5
         8M2R0uJwShb+G1RYwM9XJ/YlhIF0+Oj4NHTxxqmKvaeVBV1LX+lGCXJRIBaByIIEoEZj
         CWj0+A+VRO30DhHeHZE7dBNUR46BUItFHhg6FEXt7OPXFG1SDAQ6re6ujM/lhcqOT6kG
         lDMJtffUqbwY3daezzxRaXEqf1idGLz/CA4NqQS6yZPvS6TGQgAI9Z25C3kkAklvmw8l
         pgspsXy9F5+C47tB8aGYHJ6YstC8YBHroR7sGc+K+QccckVgKVo8rW8Cg8ajooByrLOJ
         RW8Q==
X-Gm-Message-State: APjAAAUkBNf0Cc/N6tKupnL2B7CX4uuSFFcsbjKVk09HtAcpIqyR99qo
        nLtplwM0cHIzUHrbCjSD0HLAsoXVmxjof7VAubNdV9ZUKVc=
X-Google-Smtp-Source: APXvYqy99adDKfdO/5IFHKhCHhBjd8RNyrGISrVv3D2yzM78qkZ4zOnpwQB8Jh5vRqtCOQ2IF2HbLrKgh+i5u9AqpTo=
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr17158405wrn.229.1553962399948;
 Sat, 30 Mar 2019 09:13:19 -0700 (PDT)
MIME-Version: 1.0
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
Date:   Sat, 30 Mar 2019 18:13:16 +0200
Message-ID: <CADqhmmcCA_UjV899cHn8SOTSp89BvjMgnd5TcijCWqp6KnhdJw@mail.gmail.com>
Subject: missing patch
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi back in the December of 2016 there was commit
"1c52d859cb2d417e7216d3e56bb7fea88444cec9"

witch was followed shortly by  "c198b121b1a1d7a7171770c634cd49191bac4477"

Unfortunately only the first commit was later included in long-term kernel
branches such as 4.4 and 4.9 witch left some of microcode functionality
broken on 32 bit systems

I guess it should be easily fixed by including
"c198b121b1a1d7a7171770c634cd49191bac4477" in those branches
