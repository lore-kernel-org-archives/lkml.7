Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431DCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A15F206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="D9+ksvVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfDZLFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:05:05 -0400
Received: from mx1.cock.li ([185.10.68.5]:45907 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDZLFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:05:04 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2019 07:05:03 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1556276216; bh=SN67K3e/1i58rnuu4xNZI1Mnz9oyb/gxLFWNMzVA59M=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=D9+ksvVaDaA8iiE9rda9gVFvAHoCNMxYv3STDUTIldFHmG4jyKOjOfas3kGLXu/Vt
         vI6O3YZwquQn8CKTpga9Y8s0fwMyhgZgzyOz6GrT6PQncmaZG80DSdzMtebdVwpWy0
         TC9WBu/+OU1IN40M/Oa2cKU4GoErX+tq5V8M2Fq3L+kS4Aj5T5gW4t/4oNCAEzXvbJ
         EBoPOwDWbU+s/wWAfA18/LGEWJ/FshKmE5pdVufWQ8HK/jcWM64NYYKnHRoc0aEUsG
         0ggZJGA4/O5/ZbV/L9UOy6W/dukUYZShYin3NWTuZGuEDQBIP0XkbRWW2z+ROqFU1v
         oLSNJHp2j0iqA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Apr 2019 10:56:56 +0000
From:   mikeeusa@redchan.it
To:     linux-kernel@vger.kernel.org, editor@lulz.com, misc@openbsd.org,
        esr@thyrsus.com, rms@gnu.org
Subject: GPL Is Revocable - 4chan discussion
In-Reply-To: <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5851873@github.com>
References: <5c51daed7c023_2fcf3fe7576d45c417207b@github-lowworker-89d05ac.cp1-iad.github.net.mail>
 <5c51ee838b18f_74e53fd6ff0d45c41780e2@github-lowworker-5909e27.cp1-iad.github.net.mail>
 <5c522f5b6cb8a_60733fc5256d45b412831@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c534f0336ca6_19ae3fcbf5cd45b4186161@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <5c535110f0f30_3aa13fafe46d45c4222962@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <061a28afa26cf5ad7d11f8074353a9cf@redchan.it>
 <5c5489478eb20_56f33fd9e9ad45b43146ec@github-lowworker-4f62d42.cp1-iad.github.net.mail>
 <5c55ecdcb298_3a283fd6dfcd45c4309246@github-lowworker-63e61ec.cp1-iad.github.net.mail>
 <5c563190ae6cc_18c33fcb464d45bc1523b0@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c586b095281b_4c6d3ffba28d45b8120450@github-lowworker-e51511d.cp1-iad.github.net.mail>
 <5c58a56f8ded7_36e93f9cb4ad45b8932e7@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <312c3d91f6c4a71c34b96728a2efb385@redchan.it>
 <5c5b1609a1561_1ac23fbe2d6d45b88762d0@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5812163@github.com>
 <d6326acd7a9a52a5cf4de2bd3841fc5c@redchan.it>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5851873@github.com>
Message-ID: <46801d143c79723fc8d9951fe1675d82@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

http://boards.4channel.org/g/thread/70699483

Thought you might be interested.
