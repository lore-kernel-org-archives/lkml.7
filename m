Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E3C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD612075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfCZOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:38:27 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51864 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfCZOi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:38:27 -0400
Received: from edu174238.fhi-fokus.de (edu174238.fhi-fokus.de [194.95.174.238])
        by mail.ispras.ru (Postfix) with ESMTPSA id 58D0E5400A7;
        Tue, 26 Mar 2019 17:38:22 +0300 (MSK)
Subject: Re: [PATCH v2 00/11] LSM documentation update
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <cover.1551213058.git.efremov@ispras.ru>
To:     Jonathan Corbet <corbet@lwn.net>
From:   Denis Efremov <efremov@ispras.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=efremov@ispras.ru; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f89f1335-a76a-b364-d426-b0fe3423ad0a@ispras.ru>
Date:   Tue, 26 Mar 2019 15:38:21 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: ru
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there something more I could do so that these changes are accepted?
At least this patchset fixes the documentation format for better html
generation.

Denis

26.02.2019 21:49, Denis Efremov пишет:
> Recent "New LSM Hooks" discussion has led me to the
> thought that it might be a good idea to slightly
> update the current documentation. The patchset adds
> nothing new to the documentation, only fixes the old
> description of hooks to reflect their current state.
>
> V2 adds the clarification on arguments for some hooks.
> The format of the documentation is also slightly updated
> for better html. However, there are still 10 hooks without
> documentation at all. I think that this should be fixed
> separatedly.
>
> Denis Efremov (11):
>   LSM: fix documentation for sb_copy_data hook
>   LSM: fix documentation for the syslog hook
>   LSM: fix documentation for the socket_post_create hook
>   LSM: fix documentation for the task_setscheduler hook
>   LSM: fix documentation for the socket_getpeersec_dgram hook
>   LSM: fix documentation for the path_chmod hook
>   LSM: fix documentation for the audit_* hooks
>   LSM: fix documentation for the msg_queue_* hooks
>   LSM: fix documentation for the sem_* hooks
>   LSM: fix documentation for the shm_* hooks
>   LSM: lsm_hooks.h: fix documentation format
>
>  include/linux/lsm_hooks.h | 170 ++++++++++++++++++--------------------
>  1 file changed, 81 insertions(+), 89 deletions(-)
>
