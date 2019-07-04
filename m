Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0DEC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA732083B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfGDOqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:46:37 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46295 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfGDOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:46:37 -0400
Received: by mail-ed1-f48.google.com with SMTP id d4so5632649edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 07:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VdaR0JOprmTANy9krpmiOs07z8GNtZlcwLkZ5w5pjHM=;
        b=G9lLnZoOuFbqM6AfI3wUyfPeiHWZdCcB3pntgHR1jLMA7Jsa+81e4aJ0LJ6IVlJLuI
         CWYRPZFBrqzXS8t5z6NL8ar+vwOCPk0BAub5pv6a2z1eKibu+SpJr1mRpCOVAUzorFgx
         6luUX1CBw7qcR7kuxqb2DscQUvJYSp3ESmv2RGImdL7exSom1NKgHVvGgWcHxX3Foo0g
         KXxwf/6Es1RIgou2DAKbJ4jqyugZoEgOWMu6zRMBu3t3xNSR/ij0mR63HrQN5EH+9WBN
         +7z+uZ0kWWkrJCBs+myjpO84gGZdLPB5wnr0DgkbHzMhCw1CnjB9Z29LBgTkDwjTgnsI
         3uOQ==
X-Gm-Message-State: APjAAAVp/T6pr7LEzdR4toF/8sFoduugnHHdsD2OXG8rKJ/3bTAsOm1+
        Vr8YrzFRguE4Vjo4cEuszUPj8GMN
X-Google-Smtp-Source: APXvYqwnODV5OAf1QXk4F/gkLiU2FERiOwSZDzILiLz8DNa9J+xEiE4zjlmzTfT05vJrP/XU/Yp3cA==
X-Received: by 2002:a17:906:414:: with SMTP id d20mr41496483eja.275.1562251595432;
        Thu, 04 Jul 2019 07:46:35 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id me3sm1116900ejb.21.2019.07.04.07.46.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 07:46:34 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] torture: remove exporting of internal functions
To:     paulmck@linux.ibm.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
References: <20190704125719.31290-1-efremov@linux.com>
 <20190704141919.GD26519@linux.ibm.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <e9f3fe8b-7f46-4f00-eec6-17f81ac0ac3e@linux.com>
Date:   Thu, 4 Jul 2019 17:46:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704141919.GD26519@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I reworked the commit message as follows, so could you please check
> to make sure that I didn't fold, spindle, or otherwise mutilate
> something?
> 
> 						Thanx, Paul

Perfect, thanks!

Denis
