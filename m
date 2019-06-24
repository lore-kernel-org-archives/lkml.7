Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AA22089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfFXIoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:44:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35292 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfFXIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:44:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so9416478lfg.2;
        Mon, 24 Jun 2019 01:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTeIf7xKkh2A2KoD3+Or00SIMEpyxib8waiBIUrcyAg=;
        b=XVLCBp5r9fje3/Fo7H3ivlDYSaYwVgwDsZyJ2iGRwV4AFomBUPoWrzMCZrgtsadmR+
         wKQGNYiMGJQ9DtWdqA7w0R0tt78MjgckjKfCmcJSIlSLZwCu3u8rO5PNQ7MNw5AHbyvj
         GCyfVWRX/4ki5AfBK1sA3ZOOndxIlimb/IG4RT/lZ+enkCnIAIT5lD73Jz1kZAsZIz/U
         r1t+lQa10HLz7acDN4gavXslYuPjLu+WCHzYT6F2GvSxO4Fl55wjNVj44zgKXeE8QQ50
         DqycnKo8iZVsk4dPUBnnHl/U/14mAoJRwd4ffpbzIaDdqi67e0KICWxawVuYJKayq4oA
         fQVg==
X-Gm-Message-State: APjAAAUebNS/dETdYuHLOVL61xyRV0nmU5hbtvPMXXHJayPEl4qJL5fv
        R+gvLGzM+tORerob742K6GXtKjAydcI=
X-Google-Smtp-Source: APXvYqwfFsag4uho3t2Tr17/GEZQrV0CY2It2w0W1t4jFqGN7KU4ymdaiY5qC3iE82pnWAQNwXrVyg==
X-Received: by 2002:ac2:598d:: with SMTP id w13mr72816384lfn.165.1561365875701;
        Mon, 24 Jun 2019 01:44:35 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id w28sm1624030ljd.12.2019.06.24.01.44.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:44:35 -0700 (PDT)
Subject: Re: [PATCH] parisc: asm: psw.h: missing header guard
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190623150920.26422-1-efremov@linux.com>
 <8264763.oMOxLtkXCx@daneel.sf-tec.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <00da63b3-e98d-147b-32ad-ede82d7c1e17@linux.com>
Date:   Mon, 24 Jun 2019 11:44:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8264763.oMOxLtkXCx@daneel.sf-tec.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> 
> You could have removed one of the 2 empty lines then.
> 

Will send the v2 in minutes.

Denis
