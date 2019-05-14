Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5905FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC572086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENTzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:55:25 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37555 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfENTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:55:25 -0400
Received: by mail-lf1-f53.google.com with SMTP id q17so152452lfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 12:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EChwP3DKYPjI5XpqLSr6oJaGwq6Bw/jcFqJ7qh2lsQ=;
        b=S0MGmRlrOzLqX1ezUvs+yrQA1dR3iV0DW3OUwnYoevvbvlaL1RSzHhqdlqazIN8j4w
         WU6ioF0gemD/f66Kv0Foh+kobdINoHAOdqUFWZg6F5hOMTNYxkMOir+8wvbQv2IfMRtN
         4vCdZRuvveDfBE6C+7Nbh3rLvHtpYmTZcoCqPxKl4YrdeKqDnTaEcPd+fh3qGti+mhKf
         n7wsfJ5wTBwShY8g9zX1QB3WXAkj1bBQfLqDPWHY23JjhjEG5Wj81/1JMaMRy7kXRwIg
         if64JVoCN/LlM98n5Ir12rSQEWXHK/ovs+UK5XnBp1EXcxrzIiNQTfKv4dqogAIPy9QE
         2CAg==
X-Gm-Message-State: APjAAAX3fHem5itp2pvK71Cf2QOW3nfoo/plIKahTD1k85mhfm/+KyEB
        HxDVwkg6O8pvKgIUoSfEX4+jxcsV7UPrA0YyCEvHRA==
X-Google-Smtp-Source: APXvYqzxWurvWfE/jtG7ZrK+iKrHqkmi1/rs7MROPXi7/n09L/1Rs/Rv4bP09a59natdMGzyV3Pd9g86srvzsidCM0o=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr18829823lff.27.1557863722997;
 Tue, 14 May 2019 12:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhwMSNm4uSkcGtqaGmYanfNK9rx6m2a3TqJh08YitbGAUg@mail.gmail.com>
 <20190514194249.GD12629@tower.DHCP.thefacebook.com>
In-Reply-To: <20190514194249.GD12629@tower.DHCP.thefacebook.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 14 May 2019 21:54:46 +0200
Message-ID: <CAGnkfhxwP1SwJLv2E-6Xd7ZXN8XUPRyXkM=tB0Z=jre8Rij6=A@mail.gmail.com>
Subject: Re: WARNING: CPU: 1 PID: 228 at kernel/cgroup/cgroup.c:5929
To:     Roman Gushchin <guro@fb.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

yes, this one fixes it.

-- 
Matteo Croce
per aspera ad upstream
