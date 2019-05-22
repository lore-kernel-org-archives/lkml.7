Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38085C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0962D20856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PcfrbUBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbfEVT52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:57:28 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:46034 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731273AbfEVT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558555039; bh=lxUK78hbg598LYlSBwDY5EGORMzFcW2ess5/JaNr0AU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PcfrbUBeS+bOnSQWry2tGvdZWAb24XDqo6aMGXsrRALklApn2d4k24HSjwJw89TijRRXDpYBJeJlL7wFnQVo1gkuftT3uOo7FAQi8f0ZGpMLgSE1fjxi/x3ueHjZeUuTxzPCHEHBbycHZLk63xH6zG6DhJBuh9PabpnJKn9nODk92CC/Jv2kvpBqV1QF++Bib3RRG1koA6si6d1Y6gI95ON8hcGgyCq1Y0shjzfXsgm4wb7Cg3vnZZYyOvZDZjFzf/5Y6p7NRU18c+R07pmTh9RFi3KMJe/YvylYJJ9GYtkt7CPS3ptafvSyijotN15LolI+YjwFGcA8WmKe8UwLOg==
X-YMail-OSG: 6jV9iIYVM1kyO4mEtN.FQz.IwSkedBG6_Cl759TxAMFN7pTfy3UMOYZdazIGuWz
 ZdPjt1.264z_CnqLEWbVfwlEKOX8cyVpU11WMNo8ELWJxyr4GNaQTwLJZCzIkaGtSrUvWlMruFij
 .IiN7FPvFbqqYzqWeW5DrAx.i5o_gnprk8Bu3BKFJ9XTtpXKQYe0zrv9j1d0E9NF8ZfB_G4xqIql
 axoGUoTrpH0O2PTkVNjHAxwHYBAZOsF64fFma_RFt.R_9wCnKUouHGK3QQHs.h6TjpPfBIEUApA2
 kayKvzOBr.tgBEaz3d7PsUKMLIJ5lF76qvUs4H915rBY_PZKzIk6MVmKtHa.l.C67vOclT.nT132
 C62VZWE2MtMK_btgLKsSNXIRi8JiBt8dQspjjPGYtAASmwoFkJlov9EHo.7YnLsEMAxv9ahjVcym
 Bno6.05yC2sqOhM8B_AQbvoZ_djd8I7EVGOCylM3it4A_Kc5QaIRgRTnOj5CYeCqd.YtqfCvNVNW
 jM9.cZF4sWyZQFgrkuCmeAQcPuUVgCIEQYeJGnvgbNQpkuRJBumx565iiyRhVSoGu3LgcKh_uxfg
 Sr1O9MBsUSSp7oXZvypjd9igasfeS4jX4AcnpujpBWYJP1kYXuKHXEeCMVTKH3X185GKf6z7DyoK
 E6.fNAx2ruj3KaM2g6X3NVKY6sJXP4.7K7D2gUEaY2_8vQIqJW1Ai0WZHsDZc8jCVIP9REtjOQBr
 ZMB67jYITqDVTE6QMYidVGaRo0z2ktSQ_uGVATf3a8YZKHzcTQZp2NLXo3Mqs68Vg.Awa0E.gQSe
 UfiBS5EHEk_FjwXBb3fhpCmnWbn2S7SPJbt9UZbeDAyGUn.D8u_5z6nyecMjVTYXPUmEeqAQDx5z
 h8YyU3q4KTqztQpRr6TB9fZo_iEMOXOGg_l8la5SBVO.Tbhnz.BpvoF3c6pywZTwCrv52v4bhuHO
 x.cu5Pdq_gvM6IlsgcmTUg7.cu6yHmIv3Jq26HJl157Z2HFRwvIrz1Qfco8g_aAVrxnvjcqWLdKp
 bLRivyJewEkGvjkGDDloCyPxM4EHSWREy62QrOjj68VGN6_8bxWcFo5Ky_9OM87KKuzU5d2XyKJ0
 7cV5U2VP7WdHUeZMkU8smFol1WA0oo6DnqIm9iNWCHuP7wl_BYc3vc4t4UDrChLu3Ho1ljQPDSLh
 WPUoVioO4L90d_Xu9ez3bMIaXJmKvySdig2fQfmyqTPPq4qVKwOIWCDaGaPbLIYiXNMVEjYe2kKS
 KtjJJykP5Q.dNDk10.f0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 22 May 2019 19:57:19 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID adb4da5c904a17c8b2b4ab09cd681d07;
          Wed, 22 May 2019 19:57:15 +0000 (UTC)
Subject: Re: [RFC] Turn lockdown into an LSM
To:     James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190521224013.3782-1-matthewgarrett@google.com>
 <alpine.LRH.2.21.1905221203070.3967@namei.org>
 <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com>
 <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
 <14ed1f30-a1d0-f973-5c8c-241337c8fc09@tycho.nsa.gov>
 <alpine.LRH.2.21.1905230457000.18826@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8b33a96f-160d-8e5d-4335-db2445cbe37a@schaufler-ca.com>
Date:   Wed, 22 May 2019 12:57:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1905230457000.18826@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/2019 12:19 PM, James Morris wrote:
> On Wed, 22 May 2019, Stephen Smalley wrote:
>
>> That seems to violate the intent of lockdown as I understood it, and 
>> turns security_is_locked_down() into a finer-grained capable() call. 
>> Also, if I understand correctly, this could only be done if one were to 
>> disable the lockdown module in the lsm list, since the security 
>> framework will return non-zero (i.e. the operation is locked down) if 
>> any module that implements the hook returns non-zero; LSM is 
>> "restrictive". At that point SELinux or the other LSM would be the sole 
>> arbiter of lockdown decisions. SELinux or the other LSM also wouldn't 
>> have access to the kernel_locked_down level unless that was exported in 
>> some manner from the lockdown module.  Not sure how to compose these.
> Right, I was envisaging the LSM replacing the default.
>
> i.e. the default is tristate OR fine grained LSM policy.
>
> They could in theory be composed restrictively, but this is likely not 
> useful given the coarse grained default policy.  All the LSM could do is 
> either further restrict none or integrity.
>
> We'd need to figure out how to avoid confusing users in the case where 
> multiple LSMs are registered for the hooks, possibly by having the 
> lockdown LSM gate this and update the securityfs lockdown node with 
> something like "lsm:smack".

The way I'd propose dealing with multiple LSMs using the
securityfs interface is the same as I'm proposing for
/proc/.../attr/current and SO_PEERSEC. A new interface
/proc/self/attr/display contains the name of the LSM that
the current process will see when looking at process or
security attributes that are "shared". Writing to display
is unprivileged and changes which LSM you get information
for.

Adornments like "lsm:smack" often require modification of
programs that fear change. The same would be true of a prctl().
The "display" file approach is no harder for applications that
are getting modified and much easier for scripts.

