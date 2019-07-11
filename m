Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F33C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2642D21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfGKLUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:20:10 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:40309 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728147AbfGKLUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:20:10 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id lX7Nh2wMx0SBqlX7QhCG0s; Thu, 11 Jul 2019 13:20:08 +0200
Message-ID: <9a8ed0f8e880e1a7387db00c74a9b71210ce6aff.camel@tiscali.nl>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jul 2019 13:20:05 +0200
In-Reply-To: <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNwNcIuCG+YB5xGzqEPD2NzHhGlL7n9M3ZRb6YK+JaAwLgjKXtkBGV52kFfxpiLsvhdlL4O8m+rgTZWZSQcydPJO+JgOS5oORwLAjEVmpqt9WYW9eaW1
 IxrygzODvEO/gsJvhJEbmVWqo0DjSLsALfWqiGFhhqy8Mg+0ObAXgMktoQOTiwRio3MQ0I5TSzxFCyJeEIP06UU+lXMpEld2613TcDu2dlw4YuJrwfO50uqG
 HlapxireU4EjjuH1NTVAfbE9whSsibqxIEQ7f/sUH5oH1nEST7G/AqPdWdioCQ/5QLxhDJROPbAu3sDT/kVLfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wilson schreef op do 11-07-2019 om 10:29 [+0100]:
> Temporary workaround would be to set i915.enable_psr=0

That workaround seems to work for me. Over an hour of uptime without any
screen freezes.

(I first tried fiddling with /sys/module/i915/parameters/enable_psr at
runtime, but that apparently has no effect. Should that file be read-only?)

Feel free to ask me to test a fix (or a revert) once you've figured out what
to do about this.


Paul Bolle

