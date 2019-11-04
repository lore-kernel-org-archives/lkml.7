Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AC2217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="tf3LktKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfKDL1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:27:55 -0500
Received: from mx1.cock.li ([185.10.68.5]:54733 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfKDL1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:27:54 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1572866871; bh=IFGvj7D+NPiz5qMDunjarvwZge9dYgx2KY5Ynk4oYTI=;
        h=Date:From:To:Cc:Subject:From;
        b=tf3LktKEN70ByE4Q2m4q1kbMFWSiC3LwnoIeYkvb4yEiC9HP/toMoZRtGxFqAAKGk
         pYcnNM8+XccDXdibJLuCg39HFx1uQNW2TQhBBb/HuFOS6VJmscMH11o6qB8VOhZQDv
         JrAyFLsCdBblN6FTEZeApIZOtx64C3WpTUHoInpb+kEphh4l1ZvUuuHNgEF1h9JfE3
         3JlOI3XJeFgYz0v0lfJO2e+fwJog/e6pfOhudWOXqP70IHFjXgXb2DjH+ZXwG/sV5G
         TQO6ea/whVflcfQnsuP7yFQc65QMGlRpeJvfzOt40XNABpiyd3SYzoInE31cwNVLNd
         o3u/virbVUsXQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 11:27:47 +0000
From:   gameonlinux@redchan.it
To:     gnu-misc-discuss@gnu.org
Cc:     legal@fsf.org, linux-kernel@vger.kernel.org
Subject: Why will no-one sue GrSecurity for their blatant GPL violation (of
 GCC and the linux kernel)?
Message-ID: <3a9f8c7d2a01114bbf80de212e5f7275@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Note: Sending here now as this the other list was for tech discussions 
instead)

RMS:
Could you share your thoughts, if any, of why no one will sue GrSecurity 
("Open Source Security" (a Pennsylvania company)) for their blatant 
violation of section 6 of version 2 of the GNU General Public License?

Both regarding their GCC plugins and their Linux-Kernel patch which is a 
non-separable derivative work?

They distribute such under a no-redistribution agreement to paying 
customers (the is the only distribution they do). If the customer 
redistributes the derivative works they are punished.

That is: GrSecurity (OSS) has created a contract to /Defeat/ the GPL and 
has done so successfully so far. Very successfully. The GPL is basically 
the BSD license now, since such as been allowed to stand.

This is how businesses see the GPL. They are no longer afraid: They will 
simply do what GrSecurity has done. Something that was supposed to stay 
liberated: a security patch that helped users maintain their privacy by 
not being immediately rooted when using a linux kernel on a GNU system; 
is now non-free.

With this the GPL _fails_.

NO ONE has sued GrSecurity. Thus they are seen as "having it right" 
"correct" "we can do this".

Wouldn't the FSF have standing regarding the GCC plugins atleast?
Couldn't you all rally linux-kernel copyright holders to bring a joint 
action?

References:
perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/

perens.com/static/OSS_Spenger_v_Perens/0_2018cv15189/docs1/pdf/18.pdf
(Page 10 onward of this brief gives a good recitation of the facts and 
issues

