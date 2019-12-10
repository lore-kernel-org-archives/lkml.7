Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD78CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC15820652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLJThe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:37:34 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:37:34 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M8hph-1iirvB3BKb-004jpX for <linux-kernel@vger.kernel.org>; Tue, 10 Dec
 2019 20:37:32 +0100
Received: by mail-qt1-f180.google.com with SMTP id z15so3891520qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:37:32 -0800 (PST)
X-Gm-Message-State: APjAAAW+jN8wPtH/qsZLc2IYLs1mOA2SPUcEYAbfYgte7TgyAD0RhdFL
        HOdNnCfXbb9dsakuuZTzbFOiRVPgpo+fiz55g/8=
X-Google-Smtp-Source: APXvYqxu2OeX9OeaN2eHORjywFxaUKQM7SOvVqypu3yeViJF7xtud3Js32i7/ANuafpu2FsYOmXwowjE9fDD6LyQpj0=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr31050677qte.204.1576006651717;
 Tue, 10 Dec 2019 11:37:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
 <CAK8P3a1cwoTbT3zsa-tfApwewDT1-ksHZs6_vkBYpKbgptsfjw@mail.gmail.com> <CH2PR12MB4216E04995E421F04B7662DEAE5B0@CH2PR12MB4216.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4216E04995E421F04B7662DEAE5B0@CH2PR12MB4216.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Dec 2019 20:37:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a00wfUbGU1a9nS1dtDsUo1GR1V1WqRwa+DmUKVStvicTw@mail.gmail.com>
Message-ID: <CAK8P3a00wfUbGU1a9nS1dtDsUo1GR1V1WqRwa+DmUKVStvicTw@mail.gmail.com>
Subject: Re: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:fs7GI+aJKoqupJNMo/dK9AuhCMy+PvDNlh2/vXCUfcFvm4ETsae
 8bA2NcfijzGHwXiiI3z86qp+9viR09nZN5kgmGhUgf/wz2cdMSmhp7HHVK9HTSLJ8zB0iuz
 99T8EhtJbc1YlE3ilMYMo7IIx1K43r+LvaOEF65WvyUsC9C+C3k+wCHbswqw6tg1FhPGSLk
 V/XcmqsWvX+8J5mGvyznA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jxf9fdDAvUw=:2nNk0t5IiqoiD2i0hDE9Eg
 TxJprSF9L9oN64DUEUriu+IHuUyoPGQQm6h7Ir3h2NL8GkGAi9QB6Gncy1WFgdQkQvKRDQB56
 T2JgqWGc1DJBt7PVKJ+De0GXq5jKpIQ5E0xmHfDIttTiynK+YGiyeZ4eni93zSWfCtLwb+9iM
 GsJqJ/AYQFxzeLBpM66Q5sFIeM1YmuuhjY+7vjpUCeUVNdf62o+7bTo9hy5DOBpo1LiBLIekI
 hyWp64vKfNVv2gkDcK1RcwyTsKliTzrq6UC9LeY8XMmDekDmXSmhY4VdoAoCakP3RRRjq/+HM
 xE3I2XpfleGL5pobeSZqezovLFxJWGH/QF+T7KOOklxEDPUFfrCrQdl78fvjF3+8/GiepGnGc
 F9lEKyJi2ll0B3INS5cDep58a8rGZ1rE0rJHv0CTHnVdCp1x56/9eFnBzo/WuCyG7xotKTnB/
 7G6y5qZHC0gss5AjSODrvxqPGluTmRbW8+KtcT7CAqtWSuBC4FWGxL8zOxGjW26TqQmgZknNC
 c6z8PQ3heKe96ErkPpjQvZyKQcGGHmA6u3GrKw8brg5oNu0f9DYHs240QjJLmMC6lB3mFOICI
 lxuHFFyEVbyfON8PEg62zw1TertuP+XsjxWGbro4DkUVh7fhdXxjUCMzBvNIXUt9Depb+P8ab
 fQSr5viBTNVqHHQfIjlYVcrNvI1okufPIh+OeSapOwCyuEarjNpCWixG955R9WvI1HRUKKGou
 x/WEYEh4RbcU8wqzRLXrwyQ2Ka6IkPvt+jPqWF/FXEu+oqPu0Io53J28KnUGD2+6EqqKTp/Jm
 m6vcXgSPfQ3DFxTDCalCXh6ntvbD+ho03/5KuyL1MEChGDyFjgPBTZjPX4JMKj7CctFOs7C28
 Svq0ONjSGGWkHBR+6wwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 8:15 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, Dec 10, 2019 at 17:51:14
>
> > On Tue, Dec 10, 2019 at 4:37 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > >
> > > +/* IOCTL commands */
> > > +#define I3C_DEV_IOC_MAGIC      0x07
> > > +
> > > +struct i3c_ioc_priv_xfer {
> > > +       struct i3c_priv_xfer __user *xfers;     /* pointers to i3c_priv_xfer */
> > > +       __u32 nxfers;                           /* number of i3c_priv_xfer */
> > > +};
> > > +
> > > +#define I3C_IOC_PRIV_XFER      \
> > > +       _IOW(I3C_DEV_IOC_MAGIC, 30, struct i3c_ioc_priv_xfer)
> > > +
> > > +#define  I3C_IOC_PRIV_XFER_MAX_MSGS    42
> >
> > This is not a great data structure for UAPI, please see
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_arnd_playground.git_tree_Documentation_core-2Dapi_ioctl.rst-3Fh-3Dcompat-2Dioctl-2Dendgame-26id-3D927324b7900ee9b877691a8b237e272fabb21bf5&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=5Q9WjK0o93NR7DQ9NM6So6mfdgpNnZnSaP8qMpgaC7E&s=LzzjrUQAG8fx5jkVyK73dBDrahNAvk09Cxxlx3KOiXI&e=
> >
> > for some background. I'm planning to submit that documentation for
> > mainline integration soon.
> >
> >      Arnd
>
> Thanks for sharing the document.
>
> My understanding is that I should use a data structure like the struct
> spi_ioc_transfer, with this I may also use the same ioctl command
> definition. Am I right?

Yes, that would be an example of a structure that follows the best
practices from my document. It is still rather complex, so if you
can make it any simpler, that would be ideal.

> In the documentation you also refer the compact_ioctl() and It is not
> clear to me if the compact_ioctl() is mandatory in this case. Should I
> implement it as well?

If the structure is defined like that, you just need to set
".compat_ioctl=compat_ptr_ioctl," in the file_operations structure
and it will work, but you cannot skip that step.

As your interface is basically just read/write based, I wonder
if there is a way to completely avoid the ioctl and instead
use io_submit() as the primary interface.

      Arnd
